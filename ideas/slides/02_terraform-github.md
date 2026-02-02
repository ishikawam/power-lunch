---
marp: true
theme: default
paginate: true
---

# TerraformでGitHubも管理してみた

SDBパワーランチ

---

# なぜGitHubをTerraformで管理するのか

- 新メンバー追加、リポジトリ作成がPRベースに
- 権限設定の変更履歴が残る
- 環境の再現性が上がる
- レビュープロセスを通せる

---

# Terraform GitHub Providerでできること

---

## リポジトリ管理

```hcl
resource "github_repository" "example" {
  name        = "my-repo"
  description = "My awesome repo"
  visibility  = "private"

  has_issues   = true
  delete_branch_on_merge = true
  allow_squash_merge     = true
}
```

---

## チーム・メンバー管理

```hcl
resource "github_team" "backend" {
  name        = "backend-team"
  description = "Backend developers"
  privacy     = "closed"
}

resource "github_team_membership" "member" {
  team_id  = github_team.backend.id
  username = "ishikawam"
  role     = "maintainer"
}
```

---

## Branch Protection

```hcl
resource "github_branch_protection" "main" {
  repository_id = github_repository.example.node_id
  pattern       = "main"

  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}
```

---

# GitHub Secretsの管理

---

## Actions Secrets

```hcl
resource "github_actions_secret" "aws_access_key" {
  repository      = "my-repo"
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = var.aws_access_key_id
}
```

---

## Environment Secrets

```hcl
resource "github_repository_environment" "production" {
  repository  = github_repository.example.name
  environment = "production"
}

resource "github_actions_environment_secret" "db_password" {
  repository      = github_repository.example.name
  environment     = "production"
  secret_name     = "DB_PASSWORD"
  plaintext_value = var.db_password
}
```

---

# Secretの扱いの注意点

---

## sensitive = true

```hcl
variable "db_password" {
  type      = string
  sensitive = true  # ログに出力されない
}
```

---

## stateにsecretが残る問題

- terraform.tfstateにはplaintextで保存される
- 対策:
  - S3 + 暗号化でremote state
  - Terraform Cloudを使う
  - Vault連携

---

## tfvars vs 環境変数 vs Vault

| 方法 | メリット | デメリット |
|------|---------|-----------|
| tfvars | シンプル | ファイル管理が必要 |
| 環境変数 | CI/CDと相性良い | 設定が散らばる |
| Vault | セキュア | 複雑 |

---

# まとめ

- インフラだけでなく「開発環境そのもの」もIaC化
- PRでのレビュー時にsecret値は見えない
- applyは限られたメンバーのみ

---

# ありがとうございました！
