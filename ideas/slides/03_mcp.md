---
marp: true
theme: default
paginate: true
---

# MCPサーバーの活用

SDBパワーランチ

---

# MCPとは

Model Context Protocol

Claude Codeに外部ツール連携機能を追加する仕組み

---

# 使っているMCPサーバー

- Notion
- Google Drive
- AWS Documentation
- Terraform MCP

---

## Notion

```json
{
  "mcpServers": {
    "notion": {
      "command": "npx",
      "args": ["-y", "@notionhq/notion-mcp-server"]
    }
  }
}
```

NOTION_API_KEY環境変数が必要

---

## AWS Documentation

```json
{
  "mcpServers": {
    "awslabs-aws-documentation-mcp-server": {
      "command": "uvx",
      "args": ["awslabs.aws-documentation-mcp-server@latest"]
    }
  }
}
```

---

# .envの扱いの違い

| サーバー | 環境変数の渡し方 |
|---------|-----------------|
| Notion | NOTION_API_KEY（グローバル） |
| Google Drive | credentials JSONファイル |
| AWS系 | AWS_PROFILE or 環境変数 |

---

# direnvで.envrc管理

---

## なぜdirenvか

- プロジェクトごとに環境変数を自動切り替え
- cdするだけで環境が整う
- .envrcはgitignoreに入れてローカル管理

---

## 設定例

```bash
# .envrc
export NOTION_API_KEY="secret-xxx"
export AWS_PROFILE="my-project"
```

---

## direnv + MCPの連携

1. プロジェクトディレクトリにcd
2. direnvが.envrcを読み込み
3. Claude Codeを起動
4. MCPサーバーが環境変数を参照

---

# MCPリソースの@メンション

```
@notion:page://xxx を見て
@github:issue://123 を確認して
```

---

# トラブルシューティング

- `claude --debug "mcp"` でデバッグ
- MCP_TIMEOUT環境変数でタイムアウト調整
- `/doctor` でMCP接続状態確認

---

# ありがとうございました！
