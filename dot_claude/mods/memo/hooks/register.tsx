// 選択範囲にメモを貯めて、次の発言にまとめて添える
//   選択中に Enter : 選択範囲とコメントを 1 件貯める（Claude には送らない）
//   選択なしで Enter : 貯めたメモを発言に添えて送る
//   /memo [undo|clear] : ペインを開く・最後の 1 件を消す・全件を消す
import { atom, read, update } from 'claude-code'
import type { EngineInterface, Register } from 'claude-code'

import type { Memo } from '../types'

const PANE = 'memo'
// 選択の有無を見に行く間隔
const POLL_MS = 300

const memos = atom({ plugin: 'memo', key: 'memos' } as const, [])
const selected = atom({ plugin: 'memo', key: 'selected' } as const, null)
// メモに使った選択範囲。同じ選択で 2 件目を作らないよう覚えておく
const used = atom({ plugin: 'memo', key: 'used' } as const, null)
// 編集中のメモの番号（0 始まり）
const editing = atom({ plugin: 'memo', key: 'editing' } as const, null)

const format = (list: readonly Memo[]) =>
  list
    .map((memo, i) => {
      const quote = memo.quote.replace(/^/gm, '> ')
      return `## ${i + 1}\n\n${quote}\n\n${memo.comment}`
    })
    .join('\n\n')

const open = ($: EngineInterface) => $.ui.open({ id: PANE, title: 'memo' })

// ペインを閉じる。失敗しても、メモの送信や消去は止めない
const close = ($: EngineInterface) => $.ui.close({ id: PANE }).catch(() => undefined)

// メモを空にして、ペインも閉じる
const clear = async ($: EngineInterface) => {
  await update($, memos, () => [])
  await update($, editing, () => null)
  await close($)
}

// 1 件消す。0 件になったらペインを閉じる
const remove = async ($: EngineInterface, index: number) => {
  await update($, memos, list => list.filter((_, i) => i !== index))
  await update($, editing, () => null)
  if ((await read($, memos)).length === 0) {
    await close($)
  }
}

// コメントを入力欄に戻して、編集を始める
const edit = async ($: EngineInterface, index: number) => {
  const memo = (await read($, memos))[index]
  if (memo === undefined) {
    return
  }
  await update($, editing, () => index)
  await $.prompt.fill({ text: memo.comment, mode: 'replace' })
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    await $.command.register({
      name: 'memo',
      description: 'メモのペインを開く。undo で最後の 1 件、clear で全件を消す',
      argumentHint: '[undo|clear]',
    })

    // 選択が変わったら帯を描き直す。編集中に入力欄が空になったら、編集を取り消す
    $.clock.every(POLL_MS, async () => {
      const text = (await $.ui.selection())?.text.trim() || null
      const fresh = text !== null && text !== (await read($, used)) ? text : null
      if (fresh !== (await read($, selected))) {
        await update($, selected, () => fresh)
      }
      if ((await read($, editing)) !== null && (await $.prompt.read()).text === '') {
        await update($, editing, () => null)
      }
    })

    return next(e)
  })

  on('command.run', { command: 'memo' }, async ($, e) => {
    switch (e.args.trim()) {
      case 'undo':
        await update($, memos, list => list.slice(0, -1))
        if ((await read($, memos)).length === 0) {
          await close($)
        }
        return { text: '最後のメモを消した' }
      case 'clear':
        await clear($)
        return { text: 'メモを全件消した' }
      default:
        await open($)
        return { text: 'メモのペインを開いた' }
    }
  })

  on('prompt.submit', async ($, e, next) => {
    // 自分の Enter だけを扱う。プラグインや通知からの発言は素通しする
    if (e.origin.kind !== 'composer') {
      return next(e)
    }

    const index = await read($, editing)
    if (index !== null) {
      const comment = e.text.trim()
      await update($, memos, list =>
        list.map((memo, i) => (i === index ? { ...memo, comment } : memo)),
      )
      await update($, editing, () => null)

      return { drop: `メモ ${index + 1} 件目を更新した` }
    }

    const quote = await read($, selected)
    if (quote !== null) {
      const comment = e.text.trim()
      if (comment === '') {
        return next(e)
      }
      await update($, memos, list => [...list, { quote, comment }])
      await update($, used, () => quote)
      await update($, selected, () => null)
      void open($)
      const count = (await read($, memos)).length

      return { drop: `メモ ${count} 件目を追加した` }
    }

    const list = await read($, memos)
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

    const { Text } = $.ui.resolve(e)
    const count = (await read($, memos)).length
    const index = await read($, editing)

    if (index !== null) {
      return <Text color="yellow">📝 {index + 1} 件目を編集中：Enter で更新 ・ ctrl+c で取り消し</Text>
    }
    if ((await read($, selected)) !== null) {
      return <Text color="yellow">📝 選択中：Enter でメモに追加 ・ ctrl+c で取り消し</Text>
    }
    if (count > 0) {
      return <Text dimColor>📝 メモ {count} 件：次の発言に添えて送る</Text>
    }

    return next(e)
  })

  on('ui.render', { component: 'Pane', requestId: PANE }, async ($, e) => {
    const { Box, Button, Text } = $.ui.resolve(e)
    const list = await read($, memos)

    if (list.length === 0) {
      return (
        <Box flexDirection="column">
          <Text dimColor>メモはまだない</Text>
          <Text dimColor>選択して Enter で追加</Text>
        </Box>
      )
    }

    return (
      <Box flexDirection="column">
        {list.map((memo, i) => (
          <Box key={`memo-${i}`} flexDirection="column" marginBottom={1}>
            <Text dimColor wrap="truncate-end">
              {i + 1} &gt; {memo.quote.split('\n')[0]}
            </Text>
            <Text>  → {memo.comment}</Text>
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
              const text = format(await read($, memos))
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
