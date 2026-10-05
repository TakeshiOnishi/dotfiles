export type Memo = { quote: string; comment: string }

declare module 'claude-code' {
  interface PluginState {
    memo: {
      memos: Memo[]
      selected: string | null
      used: string | null
      editing: number | null
    }
  }
}
