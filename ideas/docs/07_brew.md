# brewで入れているもの

## 概要

開発環境で使っているHomebrewパッケージの紹介

## 数字

- Formula: 143個
- Cask: 30個

## 定番ツール

### バージョン管理系

| ツール | 用途 |
|-------|------|
| asdf | 多言語バージョン管理 |
| goenv | Go バージョン管理 |
| nodenv | Node.js バージョン管理 |
| pyenv | Python バージョン管理 |
| rbenv | Ruby バージョン管理 |

### Git関連

| ツール | 用途 |
|-------|------|
| git | バージョン管理 |
| git-lfs | 大きいファイル管理 |
| gh | GitHub CLI |

### AWS関連

| ツール | 用途 |
|-------|------|
| awscli | AWS CLI |
| amazon-ecs-cli | ECS操作 |

## 便利だけど意外と知られていないツール

### direnv

```bash
brew install direnv
```

- ディレクトリごとに環境変数を自動設定
- cdするだけで環境が切り替わる
- .envrcファイルで管理

### colordiff

```bash
brew install colordiff
```

- diffの出力をカラー表示
- `alias diff='colordiff'` しておくと便利

### jq

```bash
brew install jq
```

- JSONをコマンドラインで整形・フィルタ
- APIレスポンスの確認に必須

### global (GNU GLOBAL)

```bash
brew install global
```

- ソースコードタグシステム
- 関数定義・参照のジャンプ

### actionlint

```bash
brew install actionlint
```

- GitHub Actions workflowのlinter
- CI設定のミスを事前に検出

## Cask（GUIアプリ）

### 開発ツール

| アプリ | 用途 |
|-------|------|
| docker-desktop | Docker環境 |
| iterm2 | ターミナル |
| goland | Go IDE |
| phpstorm | PHP IDE |
| sublime-text | テキストエディタ |

### ユーティリティ

| アプリ | 用途 |
|-------|------|
| alfred | ランチャー |
| alt-tab | ウィンドウ切替強化 |
| bartender | メニューバー整理 |
| clipy | クリップボード履歴 |
| karabiner-elements | キーボードカスタマイズ |

### その他

| アプリ | 用途 |
|-------|------|
| charles | HTTPプロキシ/デバッグ |
| drawio | 図表作成 |
| sequel-ace | MySQL GUI |
| handbrake-app | 動画変換 |

## brew bundleでの管理

### Brewfile

```ruby
# Brewfile
tap "homebrew/bundle"
tap "homebrew/cask"

brew "git"
brew "gh"
brew "jq"
brew "direnv"

cask "iterm2"
cask "docker-desktop"
```

### 使い方

```bash
# Brewfileからインストール
brew bundle

# 現在の状態をBrewfileに出力
brew bundle dump

# Brewfileにないものを削除
brew bundle cleanup
```

## おすすめの管理方法

1. dotfilesにBrewfileを含める
2. 新しいマシンで `brew bundle` 一発
3. 定期的に `brew bundle dump` で更新
