export type Annotation = { quote: string; comment: string }

declare module 'claude-code' {
  interface PluginState {
    'reply-annotate': {
      annotations: Annotation[]
      selected: string | null
      used: string | null
      editing: number | null
    }
  }
}
