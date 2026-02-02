---
marp: true
theme: default
paginate: true
---

# Claude Codeを本気で運用する

SDBパワーランチ

---

# 今日のアジェンダ

1. 自分だけがやっていそうなこと
2. 知らない人もいるかもなTips
3. クイズ

---

# 自分だけがやっていそうなこと

---

## 1. claude-log（548行の自作Pythonツール）

Claude Codeのログ（JSONL）をpecoライクなUIで検索・閲覧

```
$ claude-log
Claude Code ログファイルを選択
Query: taka_
sd-taka/taka-backend    01/30 15:23 (42) API認証の実装
```

---

## 2. make claude-improve-settings

全プロジェクト（14個）の権限設定を収集→グローバル設定に統合

```bash
make claude-improve-settings
# ~/git配下の.claudeディレクトリを検索
# 各プロジェクトのsettings.local.jsonから権限を抽出
# ~/.claude/settings.jsonに統合
```

---

## 3. make claude-improve-doc

全プロジェクトのCLAUDE.mdから共通ルールを抽出

```bash
make claude-improve-doc
# 各プロジェクトのCLAUDE.mdをClaudeに読ませる
# グローバル設定として良さそうなものを抽出
# ~/.claude/CLAUDE.mdに追記
```

---

## 4. 366行のグローバルCLAUDE.md

- 言語設定（日本語対応）
- Gitポリシー（git add禁止）
- 言語別開発ポリシー（Go、Laravel、Terraform）
- コメント記述ルール
- 人名表記ポリシー
- 依存関係管理

---

## 5. deny設定で危険操作をブロック

```json
"deny": [
  "Bash(git add:*)",
  "Bash(git checkout:*)",
  "Bash(git reset:*)",
  "Bash(git restore:*)"
]
```

---

# 知らない人もいるかもなTips

---

## キーボードショートカット

| ショートカット | 機能 |
|---------------|------|
| **Esc + Esc** | コード変更を巻き戻す |
| **Shift+Tab** | 権限モード切替 |
| **Ctrl+R** | 会話履歴の逆順検索 |
| **Option+T** | 拡張思考ON/OFF |
| **Option+P** | モデル切り替え |

---

## スラッシュコマンド

| コマンド | 機能 |
|---------|------|
| `/compact` | 会話を圧縮 |
| `/context` | コンテキスト使用量表示 |
| `/cost` | トークン使用統計 |
| `/doctor` | インストール状態チェック |
| `/stats` | 日次使用状況 |

---

## CLI引数

```bash
# 予算制限
claude -p --max-budget-usd 5.00 "タスク"

# ツール制限
claude --tools "Bash,Edit,Read"

# デバッグ
claude --debug "api,mcp"
```

---

## その他のTips

- `!コマンド` - Claudeの判断なしで直接実行
- CLAUDE.mdのパス別モジュール化
- Hooks機能で自動テスト実行
- Git worktreeで並列セッション

---

# クイズ「みんな知ってた？」

1. Esc+Escで巻き戻せる
2. !で直接コマンド実行
3. /compactでコンテキスト節約
4. --max-budget-usdで予算制限
5. deny設定で危険コマンドをブロック

---

# ありがとうございました！
