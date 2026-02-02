---
marp: true
theme: default
paginate: true
---

# brewで入れているもの

SDBパワーランチ

---

# 数字

- Formula: **143個**
- Cask: **30個**

---

# 定番ツール

---

## バージョン管理系

| ツール | 用途 |
|-------|------|
| asdf | 多言語バージョン管理 |
| goenv | Go バージョン管理 |
| nodenv | Node.js バージョン管理 |
| pyenv | Python バージョン管理 |
| rbenv | Ruby バージョン管理 |

---

## Git関連

| ツール | 用途 |
|-------|------|
| git | バージョン管理 |
| git-lfs | 大きいファイル管理 |
| gh | GitHub CLI |

---

# 便利だけど意外と知られていないツール

---

## direnv

```bash
brew install direnv
```

- ディレクトリごとに環境変数を自動設定
- cdするだけで環境が切り替わる

---

## colordiff

```bash
brew install colordiff
```

- diffの出力をカラー表示
- `alias diff='colordiff'` しておくと便利

---

## jq

```bash
brew install jq
```

- JSONをコマンドラインで整形・フィルタ
- APIレスポンスの確認に必須

---

## actionlint

```bash
brew install actionlint
```

- GitHub Actions workflowのlinter
- CI設定のミスを事前に検出

---

# Cask（GUIアプリ）

---

## 開発ツール

| アプリ | 用途 |
|-------|------|
| docker-desktop | Docker環境 |
| iterm2 | ターミナル |
| goland | Go IDE |
| phpstorm | PHP IDE |

---

## ユーティリティ

| アプリ | 用途 |
|-------|------|
| alfred | ランチャー |
| alt-tab | ウィンドウ切替強化 |
| bartender | メニューバー整理 |
| clipy | クリップボード履歴 |
| karabiner-elements | キーボードカスタマイズ |

---

# brew bundleでの管理

---

## Brewfile

```ruby
tap "homebrew/bundle"
tap "homebrew/cask"

brew "git"
brew "gh"
brew "jq"
brew "direnv"

cask "iterm2"
cask "docker-desktop"
```

---

## 使い方

```bash
# Brewfileからインストール
brew bundle

# 現在の状態をBrewfileに出力
brew bundle dump

# Brewfileにないものを削除
brew bundle cleanup
```

---

# おすすめの管理方法

1. dotfilesにBrewfileを含める
2. 新しいマシンで `brew bundle` 一発
3. 定期的に `brew bundle dump` で更新

---

# ありがとうございました！
