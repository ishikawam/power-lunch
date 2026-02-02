---
marp: true
theme: default
paginate: true
---

# dotfiles

SDBパワーランチ

---

# 特徴: ホームディレクトリ = Gitリポジトリ

```
~/                          ← これ自体がGitリポジトリ
├── .zshrc
├── .gitconfig
├── .vimrc
├── bin/                    ← 自作スクリプト
├── scripts/                ← セットアップスクリプト
├── private/                ← サブモジュール（別リポジトリ）
└── Library/                ← サブモジュール（macOS設定）
```

---

# 三層リポジトリ構造

| 層 | 内容 | 公開 |
|----|------|------|
| ~/（メイン） | 共通dotfiles、スクリプト | Public |
| ~/private | SSH鍵、AWS設定、秘密情報 | Private |
| ~/Library | macOSアプリ設定 | Private |

---

# .gitconfig の工夫

---

## checkout を無効化

```ini
[alias]
    co = FAIL  # switch, restoreを強制したいので
    sw = switch
    re = restore
```

なぜ？ → `git checkout` は機能が多すぎて事故の元

---

## 安全なforce push

```ini
[alias]
    pushf = push --force-with-lease --force-if-includes
```

---

## 便利なgrep

```ini
[alias]
    gr = "!git grep $1 -- './*' ':(exclude)*.min.js'
         ':(exclude)*.min.css' ':(exclude)*.tfstate' "
```

minファイルやtfstateを除外してgrep

---

## URLの書き換え

```ini
[url "ssh://git@github.com"]
    insteadOf = https://github.com
```

HTTPSのURLを自動的にSSHに変換

---

# .zshrc の工夫

---

## 履歴設定

```zsh
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history      # 時刻を残す
setopt hist_ignore_dups      # 重複を無視
```

---

## 履歴検索

```zsh
# 途中まで打ってから上下で関連履歴に
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
```

---

## 3秒以上かかった処理は詳細表示

```zsh
REPORTTIME=3
```

---

# ~/bin の自作スクリプト

| スクリプト | 用途 |
|-----------|------|
| claude-log | Claude Codeログビューア |
| updates | 全リポジトリ更新 |
| clean-empty | 空ディレクトリ削除 |
| docker-prune-all | Docker完全クリーンアップ |

---

# 新しいマシンへのセットアップ

```bash
# 1. リポジトリをclone
cd ~
git clone git@github.com:ishikawam/dotfiles.git .

# 2. サブモジュール初期化
git submodule update --init

# 3. セットアップスクリプト実行
make setup
```

---

# dotfiles管理のメリット

- 新マシンセットアップが楽
- 設定の変更履歴が残る
- 複数マシンで同じ環境
- 他の人の設定を参考にできる

---

# ありがとうございました！
