# Claude Codeを本気で運用する

## 構成案（1時間）

| 時間 | 内容 |
|------|------|
| 5分 | イントロ |
| 10分 | CLAUDE.mdを366行書いた理由 |
| 10分 | claude-logツールのデモ |
| 10分 | 複数プロジェクト統合管理の仕組み |
| 5分 | やらかし防止の設定テクニック |
| 20分 | みんなで触ってみる・質疑応答 |

## 自分だけがやっていそうなこと

### 1. claude-log（548行の自作Pythonツール）

Claude Codeのログ（JSONL）をpecoライクなUIで検索・閲覧

```
$ claude-log
Claude Code ログファイルを選択
Query: taka_
sd-taka/taka-backend    01/30 15:23 (42) API認証の実装
```

- インクリメンタル検索
- カラー表示
- プロジェクト横断で過去のやり取りを検索

### 2. make claude-improve-settings

全プロジェクト（14個）の権限設定を収集→グローバル設定に統合

```bash
make claude-improve-settings
# ~/git配下の.claudeディレクトリを検索
# 各プロジェクトのsettings.local.jsonから権限を抽出
# ~/.claude/settings.jsonに統合
```

### 3. make claude-improve-doc

全プロジェクトのCLAUDE.mdから共通ルールを抽出

```bash
make claude-improve-doc
# 各プロジェクトのCLAUDE.mdをClaudeに読ませる
# グローバル設定として良さそうなものを抽出
# ~/.claude/CLAUDE.mdに追記
```

### 4. 366行のグローバルCLAUDE.md

- 言語設定（日本語対応）
- Gitポリシー（git add禁止、コミットメッセージ作成手順）
- 言語別開発ポリシー（Go、Laravel、Terraform）
- コメント記述ルール（「駆逐」「撲滅」禁止）
- 人名表記ポリシー（漢字推測禁止）
- 依存関係管理（brew前にMakefile必須）

### 5. deny設定で危険操作をブロック

```json
"deny": [
  "Bash(git add:*)",
  "Bash(git checkout:*)",
  "Bash(git reset:*)",
  "Bash(git restore:*)"
]
```

## 知らない人もいるかもなTips

### キーボードショートカット

| ショートカット | 機能 |
|---------------|------|
| **Esc + Esc** | コード変更を巻き戻す（checkpoint） |
| **Shift+Tab** | 権限モード切替（Normal↔Plan↔Auto-Accept） |
| **Ctrl+R** | 会話履歴の逆順検索 |
| **Option+T** | 拡張思考ON/OFF |
| **Option+P** | モデル切り替え（プロンプト保持） |
| **Ctrl+B** | タスクをバックグラウンドに |

### スラッシュコマンド

| コマンド | 機能 |
|---------|------|
| `/compact` | 会話を圧縮（コンテキスト節約） |
| `/context` | コンテキスト使用量表示 |
| `/cost` | トークン使用統計 |
| `/doctor` | インストール状態チェック |
| `/stats` | 日次使用状況、連続記録 |
| `/vim` | Vimスタイル編集有効化 |
| `/tasks` | バックグラウンドタスク一覧 |

### CLI引数

```bash
# 予算制限
claude -p --max-budget-usd 5.00 "タスク"

# ツール制限
claude --tools "Bash,Edit,Read"

# リモートセッション
claude --remote "タスク"

# デバッグ
claude --debug "api,mcp"
```

### その他

- `!コマンド` - Claudeの判断なしで直接実行
- CLAUDE.mdのパス別モジュール化（`.claude/rules/`）
- Hooks機能で自動テスト実行
- `@github:issue://123` でMCPリソース参照
- Git worktreeで並列セッション

### settings.jsonの隠れオプション

```json
{
  "alwaysThinkingEnabled": true,
  "showTurnDuration": true,
  "spinnerTipsEnabled": false,
  "sandbox": { "enabled": true }
}
```

## クイズ形式案

「みんな知ってた？」で挙手してもらう

1. Esc+Escで巻き戻せる
2. !で直接コマンド実行
3. /compactでコンテキスト節約
4. --max-budget-usdで予算制限
5. Hooksでタスク完了時に自動テスト
6. deny設定で危険コマンドをブロック
