# Power Lunch

SDBパワーランチの発表資料管理リポジトリ

## 概要

このリポジトリはClaude Codeを活用して発表資料を作成・管理しています。

## ディレクトリ構成

```
.
├── 01/                     # 第1回発表資料
│   ├── announcement.md     # 告知文
│   ├── script.md           # 発表原稿
│   └── slide.md            # スライド（Marp形式）
├── ideas/                  # ネタ候補
│   ├── docs/               # 原稿・メモ
│   └── slides/             # スライド（Marp形式）
├── dist/                   # 生成物（HTML/PDF）
└── Makefile
```

## ワークフロー

### 1. ネタ出し

```
ideas/docs/ に新しいネタ候補を作成して
```

### 2. 原稿からスライド生成

```
ideas/docs/01_claude-code.md を元に Marp形式のスライドを作成して
ideas/slides/01_claude-code.md に保存して
```

### 3. 発表資料の確定

発表が決まったら、該当のスライドを元に発表用ディレクトリを作成:

```
ideas/slides/12_conferences.md を元に、第1回発表用の資料を作成して
01/slide.md に保存して
告知文と発表原稿も作成して
```

### 4. HTML/PDF生成

```bash
make html         # 全スライドをHTMLに変換
make pdf          # 全スライドをPDFに変換
make preview      # 選択してプレビュー
make open         # 選択してHTMLを開く
```

## Makeコマンド

```bash
make              # ヘルプ表示
make html         # 全スライドをHTMLに変換
make pdf          # 全スライドをPDFに変換
make preview      # スライドを選択してプレビュー
make open         # スライドを選択してHTMLを開く
make lint         # Markdownをリント
make fix          # Markdownを自動修正
make clean        # 生成ファイル削除
```

## Claude Codeプロンプト例

### ネタ候補の追加

```
パワーランチのネタ候補として「GitHub Actions入門」を追加して
ideas/docs/13_github-actions.md に保存して
```

### 原稿の深掘り

```
ideas/docs/01_claude-code.md をもっと詳しく書いて
実際の設定例やコード例も追加して
```

### スライド生成

```
ideas/docs/01_claude-code.md を元にMarp形式のスライドを作成して
1スライド1トピックで、箇条書きは5項目以内で
ideas/slides/01_claude-code.md に保存して
```

### 告知文作成

```
第2回パワーランチの告知文を作成して
日時: 2/12(水) 12:00
場所: 09-02
テーマ: Claude Code活用術
Slack投稿用のフォーマットで
```

## 依存ツール

- [Marp CLI](https://github.com/marp-team/marp-cli)
- [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli)

npx経由で実行するため、事前インストール不要。
