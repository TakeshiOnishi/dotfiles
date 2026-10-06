// 選択範囲に注釈を貯めて、次の発言にまとめて添える
//   /an <コメント> : 選択範囲とコメントを 1 件貯める（Claude には送らない）
//   /an paste      : 貯めた注釈を入力欄へ入れて、貯めた分を空にする
//   /an undo       : 最後の 1 件を消す
//   /an clear      : 全件を消す
//   /an            : ペインを開く
//   選択なしで Enter : 貯めた注釈を発言に添えて送る
// 選択中は入力欄の上の帯にコメント欄を出す。herdr の ctrl+t → m（ctrl+x tab を送る）で帯へ移り、
// Enter で 1 件貯める。プロンプトを送らないので、会話ログは最下部へ飛ばない
import { atom, read, update } from 'claude-code'
import type { EngineInterface, Register } from 'claude-code'

import type { Annotation } from '../types'

const PANE = 'reply-annotate'
const COMMAND = 'an'
// 入力欄が /an を書きかけているか
const COMPOSING = new RegExp(`^/${COMMAND}(\\s|$)`)
// 選択の有無を見に行く間隔
const POLL_MS = 300
// ペインの幅。端末幅に対する割合と、読める下限の桁数
const PANE_RATIO = 0.15
const PANE_MIN_COLUMNS = 24
// 端末幅が分からないとき（プラグインからの実行など）に使う幅
const FALLBACK_COLUMNS = 80
// 帯の右端にエンジンが取る桁数（[-] の分）
const BAND_MARK_COLUMNS = 5

const annotations = atom({ plugin: 'reply-annotate', key: 'annotations' } as const, [])
const selected = atom({ plugin: 'reply-annotate', key: 'selected' } as const, null)
// 注釈に使った選択範囲。同じ選択で 2 件目を作らないよう覚えておく
const used = atom({ plugin: 'reply-annotate', key: 'used' } as const, null)
// 編集中の注釈の番号（0 始まり）
const editing = atom({ plugin: 'reply-annotate', key: 'editing' } as const, null)
// 入力欄が /an で始まっているか。選択中の帯は、このときだけ出す
const composing = atom({ plugin: 'reply-annotate', key: 'composing' } as const, false)
// 前回見た入力欄の文字。選択後に変わったら、コピー用の選択とみなして帯を消す
const draft = atom({ plugin: 'reply-annotate', key: 'draft' } as const, '')

// 先頭に見出しを置き、「番号: 引用」の後に空行を挟んでコメントを書く。引用の 2 行目以降は字下げする
const format = (list: readonly Annotation[]) =>
  [
    '引用して指摘・質問',
    ...list.map((annotation, i) => {
      const quote = annotation.quote.replace(/\n/g, '\n   ')
      return `${i + 1}: ${quote}\n\n${annotation.comment}`
    }),
  ].join('\n\n')

const firstLine = (text: string) => text.split('\n')[0] ?? ''

const open = ($: EngineInterface, terminalColumns: number) =>
  $.ui.open({
    id: PANE,
    title: 'reply-annotate',
    columns: Math.max(PANE_MIN_COLUMNS, Math.round(terminalColumns * PANE_RATIO)),
  })

// ペインを閉じる。失敗しても、注釈の送信や消去は止めない
const close = ($: EngineInterface) => $.ui.close({ id: PANE }).catch(() => undefined)

// 注釈を空にして、ペインも閉じる
const clear = async ($: EngineInterface) => {
  await update($, annotations, () => [])
  await update($, editing, () => null)
  await close($)
}

// 選択範囲とコメントを 1 件貯める。選択がなければ toast で伝える
const add = async ($: EngineInterface, comment: string, terminalColumns: number) => {
  const quote = await read($, selected)
  if (quote === null) {
    $.ui.toast('選択範囲がない。注釈する箇所を選択してから実行する')
    return
  }
  await update($, annotations, list => [...list, { quote, comment }])
  await update($, used, () => quote)
  await update($, selected, () => null)
  await open($, terminalColumns)
  const count = (await read($, annotations)).length
  $.ui.toast(`注釈 ${count} 件目を追加した`)
}

// 1 件消す。0 件になったらペインを閉じる
const remove = async ($: EngineInterface, index: number) => {
  await update($, annotations, list => list.filter((_, i) => i !== index))
  await update($, editing, () => null)
  if ((await read($, annotations)).length === 0) {
    await close($)
  }
}

// コメントを入力欄に戻して、編集を始める
const edit = async ($: EngineInterface, index: number) => {
  const annotation = (await read($, annotations))[index]
  if (annotation === undefined) {
    return
  }
  await update($, editing, () => index)
  await $.prompt.fill({ text: annotation.comment, mode: 'replace' })
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    await $.command.register({
      name: COMMAND,
      description: '選択範囲に注釈を貯める。paste で入力欄へ入れる、undo で最後の 1 件、clear で全件を消す',
      argumentHint: '<コメント>|paste|undo|clear',
    })

    // 選択や入力欄が変わったら帯を描き直す。編集中に入力欄が空になったら、編集を取り消す
    $.clock.every(POLL_MS, async () => {
      const text = (await $.ui.selection())?.text.trim() || null
      const fresh = text !== null && text !== (await read($, used)) ? text : null
      if (fresh !== (await read($, selected))) {
        await update($, selected, () => fresh)
      }
      const typed = (await $.prompt.read()).text
      const isComposing = COMPOSING.test(typed)
      if (isComposing !== (await read($, composing))) {
        await update($, composing, () => isComposing)
      }
      // 選択したまま入力欄に打ち続けたら、注釈ではなくコピー用の選択だったとみなす。
      // /an を打ちかけている途中（/ や /a）では消さない
      if (typed !== (await read($, draft))) {
        await update($, draft, () => typed)
        const quote = await read($, selected)
        if (quote !== null && !typed.startsWith('/')) {
          await update($, used, () => quote)
          await update($, selected, () => null)
        }
      }
      if ((await read($, editing)) !== null && typed === '') {
        await update($, editing, () => null)
      }
    })

    return next(e)
  })

  // 結果は toast で伝え、command の出力行には何も出さない（Claude に読ませない）
  on('command.run', { command: COMMAND }, async ($, e) => {
    const args = e.args.trim()
    switch (args) {
      case '':
        await open($, e.presentation?.columns ?? FALLBACK_COLUMNS)
        return {}
      case 'paste': {
        const list = await read($, annotations)
        if (list.length === 0) {
          $.ui.toast('貯めた注釈がない')
          return {}
        }
        await clear($)
        await $.prompt.fill({ text: format(list), mode: 'insert' })
        return {}
      }
      case 'undo':
        await update($, annotations, list => list.slice(0, -1))
        await update($, editing, () => null)
        if ((await read($, annotations)).length === 0) {
          await close($)
        }
        $.ui.toast('最後の注釈を消した')
        return {}
      case 'clear':
        await clear($)
        $.ui.toast('注釈を全件消した')
        return {}
    }

    await add($, args, e.presentation?.columns ?? FALLBACK_COLUMNS)

    return {}
  })

  on('prompt.submit', async ($, e, next) => {
    // 自分の Enter だけを扱う。プラグインや通知からの発言は素通しする
    if (e.origin.kind !== 'composer') {
      return next(e)
    }

    const index = await read($, editing)
    if (index !== null) {
      const comment = e.text.trim()
      await update($, annotations, list =>
        list.map((annotation, i) => (i === index ? { ...annotation, comment } : annotation)),
      )
      await update($, editing, () => null)

      return { drop: `注釈 ${index + 1} 件目を更新した` }
    }

    const list = await read($, annotations)
    if (list.length === 0) {
      return next(e)
    }
    await clear($)

    return next({ ...e, text: `${e.text}\n\n${format(list)}` })
  })

  on('ui.render', { component: 'AbovePrompt' }, async ($, e, next) => {
    if (e.props.hasSurvey) {
      return next(e)
    }

    const { Box, Input, Text } = $.ui.resolve(e)
    const list = await read($, annotations)
    const index = await read($, editing)

    if (index !== null) {
      return (
        <Text color="yellow" wrap="truncate-end">
          📝 {index + 1} 件目「{firstLine(list[index]?.quote ?? '')}」を編集中：Enter で更新 ・ 入力欄を空にすると取り消し
        </Text>
      )
    }
    const quote = await read($, selected)
    if (quote !== null && (await read($, composing))) {
      return (
        <Text color="yellow" wrap="truncate-end">
          📝 「{firstLine(quote)}」 → /an コメント で注釈に追加
        </Text>
      )
    }
    // 送信せずに貯めるコメント欄。帯へ移ったらすぐ打てるよう autoFocus にする
    if (quote !== null) {
      return (
        <Box flexDirection="column">
          <Text color="yellow" wrap="truncate-end">
            📝 「{firstLine(quote)}」 → ctrl+t → m でコメントを書き、Enter で注釈に追加
          </Text>
          <Input
            key="comment"
            label="注釈"
            placeholder="コメント"
            submitLabel="貯める"
            autoFocus
            onSubmit={async value => {
              const comment = value.trim()
              if (comment !== '') {
                // 帯の幅に、エンジンが右端に取る 5 桁を足して端末幅とみなす
                await add($, comment, e.props.bodyColumns + BAND_MARK_COLUMNS)
              }
            }}
          />
        </Box>
      )
    }
    if (list.length > 0) {
      return <Text dimColor>📝 注釈 {list.length} 件：次の発言に添えて送る</Text>
    }

    return next(e)
  })

  on('ui.render', { component: 'Pane', requestId: PANE }, async ($, e) => {
    const { Box, Button, Text } = $.ui.resolve(e)
    const list = await read($, annotations)

    if (list.length === 0) {
      return (
        <Box flexDirection="column">
          <Text dimColor>注釈はまだない</Text>
          <Text dimColor>選択して /an コメント で追加</Text>
        </Box>
      )
    }

    return (
      <Box flexDirection="column">
        {list.map((annotation, i) => (
          <Box key={`annotation-${i}`} flexDirection="column" marginBottom={1}>
            <Text dimColor wrap="truncate-end">
              {i + 1} &gt; {firstLine(annotation.quote)}
            </Text>
            <Text>  → {annotation.comment}</Text>
            <Box>
              <Text>  </Text>
              <Button key={`edit-${i}`} label="編集" onPress={() => edit($, i)} />
              <Text> </Text>
              <Button key={`remove-${i}`} label="削除" onPress={() => remove($, i)} />
            </Box>
          </Box>
        ))}
        <Box>
          <Button
            key="send"
            label="送信"
            onPress={async () => {
              const text = format(await read($, annotations))
              await clear($)
              await $.prompt.submit({ text })
            }}
          />
          <Text> </Text>
          <Button key="clear" label="全消去" onPress={() => clear($)} />
        </Box>
      </Box>
    )
  })
}
