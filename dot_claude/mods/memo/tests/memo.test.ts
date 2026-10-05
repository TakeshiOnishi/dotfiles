import { expect, mock, test } from 'claude-code/testing'
import type { On } from 'claude-code'

const enter = (text: string) => ({ text, wait: false, origin: { kind: 'composer' } as const })

// 選択範囲と送られた発言を差し替えて記録する
const setup = (on: On) => {
  const clock = mock.clock(on)
  const state = {
    selection: undefined as string | undefined,
    sent: [] as string[],
    isOpen: false,
  }
  on('ui.selection', () => ({
    value: state.selection === undefined ? undefined : { text: state.selection },
  }))
  on('session.start', (_$, e) => ({ cwd: e.cwd }))
  on('command.register', (_$, e) => ({ value: { command: e.name } }))
  on('ui.open', () => {
    state.isOpen = true
    return { value: { isPlaced: true } as const }
  })
  on('ui.close', () => {
    state.isOpen = false
    return { value: undefined }
  })
  on('prompt.submit', (_$, e) => {
    state.sent.push(e.text)
    return { text: e.text }
  })
  return { clock, state }
}

test('選択中の Enter はメモになり、次の発言に添えて送られる', async ($, on) => {
  const { clock, state } = setup(on)
  await $.session.start({ cwd: '/', surface: 'terminal', isInteractive: true })
  // メモがないうちはペインを開かない
  expect(state.isOpen).toBe(false)

  state.selection = '選択した行'
  await clock.advance(300)
  const first = await $.prompt.submit(enter('根拠は？'))
  expect(first.drop).toBe('メモ 1 件目を追加した')
  expect(state.sent).toEqual([])
  expect(state.isOpen).toBe(true)

  // 同じ選択が残っていても、2 件目にはしない
  await clock.advance(300)
  await $.prompt.submit(enter('普通の発言'))
  expect(state.sent).toEqual(['普通の発言\n\n## 1\n\n> 選択した行\n\n根拠は？'])
  // 送ったらペインを閉じる
  expect(state.isOpen).toBe(false)

  state.selection = '別の行'
  await clock.advance(300)
  const second = await $.prompt.submit(enter('5 回にして'))
  expect(second.drop).toBe('メモ 1 件目を追加した')
})

const PANE = {
  plugin: 'memo',
  surface: 'terminal',
  component: 'Pane',
  requestId: 'memo',
  props: {
    title: 'memo',
    isFocused: true,
    bodyColumns: 40,
    placement: 'dock',
    scroll: { offset: 0, bodyRows: 20 },
    view: {},
  },
} as const

test('ペインのボタンで 1 件を削除・編集できる', async ($, on) => {
  const { clock, state } = setup(on)
  const box = { text: '' }
  on('prompt.fill', (_$, e) => {
    box.text = e.text
    return { isFilled: true, text: e.text }
  })
  on('prompt.read', () => ({ value: { text: box.text, cursor: box.text.length } }))
  await $.session.start({ cwd: '/', surface: 'terminal', isInteractive: true })

  for (const [quote, comment] of [['一行目', 'A'], ['二行目', 'B'], ['三行目', 'C']]) {
    state.selection = quote
    await clock.advance(300)
    await $.prompt.submit(enter(comment ?? ''))
  }

  const ui = await $.ui.mount(PANE)
  await ui.press({ key: 'remove-0' })
  await ui.press({ key: 'edit-0' })
  expect(box.text).toBe('B')

  const updated = await $.prompt.submit(enter('B を直した'))
  expect(updated.drop).toBe('メモ 1 件目を更新した')

  state.selection = undefined
  await clock.advance(300)
  await $.prompt.submit(enter('送る'))
  expect(state.sent).toEqual([
    '送る\n\n## 1\n\n> 二行目\n\nB を直した\n\n## 2\n\n> 三行目\n\nC',
  ])
  await ui.unmount()
})

test('編集中に入力欄を空にすると、編集を取り消す', async ($, on) => {
  const { clock, state } = setup(on)
  const box = { text: '' }
  on('prompt.fill', (_$, e) => {
    box.text = e.text
    return { isFilled: true, text: e.text }
  })
  on('prompt.read', () => ({ value: { text: box.text, cursor: box.text.length } }))
  await $.session.start({ cwd: '/', surface: 'terminal', isInteractive: true })

  state.selection = '一行目'
  await clock.advance(300)
  await $.prompt.submit(enter('A'))

  const ui = await $.ui.mount(PANE)
  await ui.press({ key: 'edit-0' })
  box.text = ''
  await clock.advance(300)

  state.selection = undefined
  await $.prompt.submit(enter('送る'))
  expect(state.sent).toEqual(['送る\n\n## 1\n\n> 一行目\n\nA'])
  await ui.unmount()
})

test('メモがなく選択もない発言は、そのまま送られる', async ($, on) => {
  const { state } = setup(on)
  await $.session.start({ cwd: '/', surface: 'terminal', isInteractive: true })

  await $.prompt.submit(enter('こんにちは'))
  expect(state.sent).toEqual(['こんにちは'])
})
