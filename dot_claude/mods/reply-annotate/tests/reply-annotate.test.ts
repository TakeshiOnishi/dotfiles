import { expect, mock, test } from 'claude-code/testing'
import type { On } from 'claude-code'

const enter = (text: string) => ({ text, wait: false, origin: { kind: 'composer' } as const })
const an = (args: string) => ({ command: 'an', args })

// 選択範囲・送られた発言・入力欄・toast を差し替えて記録する
const setup = (on: On) => {
  const clock = mock.clock(on)
  const state = {
    selection: undefined as string | undefined,
    sent: [] as string[],
    box: '',
    toasts: [] as string[],
    isOpen: false,
    columns: undefined as number | undefined,
  }
  on('ui.selection', () => ({
    value: state.selection === undefined ? undefined : { text: state.selection },
  }))
  on('session.start', (_$, e) => ({ cwd: e.cwd }))
  on('command.register', (_$, e) => ({ value: { command: e.name } }))
  on('ui.open', (_$, e) => {
    state.isOpen = true
    state.columns = e.columns
    return { value: { isPlaced: true } as const }
  })
  on('ui.close', () => {
    state.isOpen = false
    return { value: undefined }
  })
  on('ui.toast', (_$, e) => {
    state.toasts.push(e.text)
    return { value: undefined }
  })
  on('prompt.fill', (_$, e) => {
    state.box = e.text
    return { isFilled: true, text: e.text }
  })
  on('prompt.read', () => ({ value: { text: state.box, cursor: state.box.length } }))
  on('prompt.submit', (_$, e) => {
    state.sent.push(e.text)
    return { text: e.text }
  })
  return { clock, state }
}

const start = { cwd: '/', surface: 'terminal', isInteractive: true } as const

// 選択してから /an を実行する
const annotate = async (
  $: Parameters<Parameters<typeof test>[1]>[0],
  { clock, state }: ReturnType<typeof setup>,
  quote: string,
  comment: string,
) => {
  state.selection = quote
  await clock.advance(300)
  await $.command.run(an(comment))
}

test('選択中でも Enter は横取りせず、そのまま送られる', async ($, on) => {
  const { clock, state } = setup(on)
  await $.session.start(start)

  state.selection = 'コピーしたい行'
  await clock.advance(300)
  await $.prompt.submit(enter('普通の発言'))
  expect(state.sent).toEqual(['普通の発言'])
  expect(state.isOpen).toBe(false)
})

test('/an で注釈を貯め、次の発言に添えて送る', async ($, on) => {
  const ctx = setup(on)
  const { clock, state } = ctx
  await $.session.start(start)

  await annotate($, ctx, '選択した行', '根拠は？')
  expect(state.toasts).toEqual(['注釈 1 件目を追加した'])
  expect(state.sent).toEqual([])
  // 1 件でも貯まったらペインを開く。幅は端末幅の 15% で、下限は 24 桁
  expect(state.isOpen).toBe(true)
  expect(state.columns).toBeGreaterThanOrEqual(24)

  // 同じ選択が残っていても、2 件目にはしない
  await clock.advance(300)
  await $.command.run(an('もう一度'))
  expect(state.toasts.at(-1)).toBe('選択範囲がない。注釈する箇所を選択してから実行する')

  await $.prompt.submit(enter('普通の発言'))
  expect(state.sent).toEqual(['普通の発言\n\n引用して指摘・質問\n\n1: 選択した行\n\n根拠は？'])
  // 送ったらペインを閉じる
  expect(state.isOpen).toBe(false)
})

test('/an paste で注釈を入力欄へ入れ、貯めた分を空にする', async ($, on) => {
  const ctx = setup(on)
  const { state } = ctx
  await $.session.start(start)

  await annotate($, ctx, '一行目', 'A')
  await annotate($, ctx, '二行目', 'B')
  await $.command.run(an('paste'))
  expect(state.box).toBe('引用して指摘・質問\n\n1: 一行目\n\nA\n\n2: 二行目\n\nB')
  expect(state.isOpen).toBe(false)

  // 貼り付けた後の発言には、もう添えない
  state.selection = undefined
  await $.prompt.submit(enter('送る'))
  expect(state.sent).toEqual(['送る'])

  await $.command.run(an('paste'))
  expect(state.toasts.at(-1)).toBe('貯めた注釈がない')
})

test('/an undo と /an clear で注釈を消す', async ($, on) => {
  const ctx = setup(on)
  const { state } = ctx
  await $.session.start(start)

  await annotate($, ctx, '一行目', 'A')
  await annotate($, ctx, '二行目', 'B')
  await $.command.run(an('undo'))
  await $.command.run(an('paste'))
  expect(state.box).toBe('引用して指摘・質問\n\n1: 一行目\n\nA')

  await annotate($, ctx, '三行目', 'C')
  await $.command.run(an('clear'))
  expect(state.isOpen).toBe(false)
  state.selection = undefined
  await $.prompt.submit(enter('送る'))
  expect(state.sent).toEqual(['送る'])
})

const PANE = {
  plugin: 'reply-annotate',
  surface: 'terminal',
  component: 'Pane',
  requestId: 'reply-annotate',
  props: {
    title: 'reply-annotate',
    isFocused: true,
    bodyColumns: 40,
    placement: 'dock',
    scroll: { offset: 0, bodyRows: 20 },
    view: {},
  },
} as const

test('ペインのボタンで 1 件を削除・編集できる', async ($, on) => {
  const ctx = setup(on)
  const { clock, state } = ctx
  await $.session.start(start)

  for (const [quote, comment] of [['一行目', 'A'], ['二行目', 'B'], ['三行目', 'C']]) {
    await annotate($, ctx, quote ?? '', comment ?? '')
  }

  const ui = await $.ui.mount(PANE)
  await ui.press({ key: 'remove-0' })
  await ui.press({ key: 'edit-0' })
  expect(state.box).toBe('B')

  const updated = await $.prompt.submit(enter('B を直した'))
  expect(updated.drop).toBe('注釈 1 件目を更新した')

  state.selection = undefined
  await clock.advance(300)
  await $.prompt.submit(enter('送る'))
  expect(state.sent).toEqual([
    '送る\n\n引用して指摘・質問\n\n1: 二行目\n\nB を直した\n\n2: 三行目\n\nC',
  ])
  await ui.unmount()
})

test('編集中に入力欄を空にすると、編集を取り消す', async ($, on) => {
  const ctx = setup(on)
  const { clock, state } = ctx
  await $.session.start(start)

  await annotate($, ctx, '一行目', 'A')

  const ui = await $.ui.mount(PANE)
  await ui.press({ key: 'edit-0' })
  state.box = ''
  await clock.advance(300)

  state.selection = undefined
  await $.prompt.submit(enter('送る'))
  expect(state.sent).toEqual(['送る\n\n引用して指摘・質問\n\n1: 一行目\n\nA'])
  await ui.unmount()
})

const BAND = {
  plugin: 'reply-annotate',
  surface: 'terminal',
  component: 'AbovePrompt',
  props: { hasSurvey: false, bodyColumns: 115 },
} as const

test('/an の案内は、入力欄が /an で始まるときだけ出す', async ($, on) => {
  const { clock, state } = setup(on)
  // 帯に何も出さないときは、エンジンの描画（ここでは空）に任せる
  on('ui.render', ($, e) => $.ui.resolve(e).Box({}))
  await $.session.start(start)
  const ui = await $.ui.mount(BAND)

  // 選択しただけでは、/an の案内ではなくコメント欄を出す
  state.selection = '選択した行'
  await clock.advance(300)
  expect(await ui.find({ text: /\/an コメント/ })).toBeUndefined()
  expect(await ui.find({ key: 'comment' })).toBeDefined()

  // /an を書き始めたら案内を出す
  state.box = '/an '
  await clock.advance(300)
  expect(await ui.find({ text: /\/an コメント/ })).toBeDefined()

  // /analysis のような別のコマンドでは出さない
  state.box = '/analysis'
  await clock.advance(300)
  expect(await ui.find({ text: /\/an コメント/ })).toBeUndefined()
  await ui.unmount()
})

test('複数行の引用は、2 行目以降を字下げする', async ($, on) => {
  const ctx = setup(on)
  const { state } = ctx
  await $.session.start(start)

  await annotate($, ctx, '一行目\n二行目', 'A')
  await $.command.run(an('paste'))
  expect(state.box).toBe('引用して指摘・質問\n\n1: 一行目\n   二行目\n\nA')
})

test('選択中は帯のコメント欄で、送信せずに注釈を貯める', async ($, on) => {
  const { clock, state } = setup(on)
  on('ui.render', ($, e) => $.ui.resolve(e).Box({}))
  await $.session.start(start)
  const ui = await $.ui.mount(BAND)

  // 選択していなければコメント欄を出さない
  expect(await ui.find({ key: 'comment' })).toBeUndefined()

  state.selection = '選択した行'
  await clock.advance(300)
  expect(await ui.find({ key: 'comment' })).toBeDefined()

  // 空のコメントは貯めない
  await ui.input({ key: 'comment', text: '  ' })
  expect(state.toasts).toEqual([])

  await ui.input({ key: 'comment', text: '根拠は？' })
  expect(state.toasts).toEqual(['注釈 1 件目を追加した'])
  // 帯のコメント欄では発言を送らない
  expect(state.sent).toEqual([])
  expect(state.isOpen).toBe(true)
  // 貯めたらコメント欄を閉じる
  expect(await ui.find({ key: 'comment' })).toBeUndefined()

  state.selection = undefined
  await $.prompt.submit(enter('普通の発言'))
  expect(state.sent).toEqual(['普通の発言\n\n引用して指摘・質問\n\n1: 選択した行\n\n根拠は？'])
  await ui.unmount()
})
