# MCPサーバーの活用

## MCPとは

Model Context Protocol - Claude Codeに外部ツール連携機能を追加する仕組み

## 使っているMCPサーバー

### Notion

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

- Notionのページ・データベースにアクセス
- NOTION_API_KEY環境変数が必要

### Google Drive

```json
{
  "mcpServers": {
    "google-drive": {
      "command": "npx",
      "args": ["@piotr-agier/google-drive-mcp"],
      "env": {
        "GOOGLE_DRIVE_OAUTH_CREDENTIALS": "./credentials/client_secret.json"
      }
    }
  }
}
```

### AWS Documentation

```json
{
  "mcpServers": {
    "awslabs-aws-documentation-mcp-server": {
      "command": "uvx",
      "args": ["awslabs.aws-documentation-mcp-server@latest"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR"
      }
    }
  }
}
```

### Terraform MCP

```json
{
  "mcpServers": {
    "awslabs-terraform-mcp-server": {
      "command": "uvx",
      "args": ["awslabs.terraform-mcp-server@latest"]
    }
  }
}
```

## .envの扱いの違い

### MCPサーバーごとに異なる

| サーバー | 環境変数の渡し方 |
|---------|-----------------|
| Notion | NOTION_API_KEY（グローバル） |
| Google Drive | credentials JSONファイル |
| AWS系 | AWS_PROFILE or 環境変数 |

### .mcp.json内での環境変数展開

```json
{
  "env": {
    "API_KEY": "${MY_API_KEY}"
  }
}
```

## direnvで.envrc管理

### なぜdirenvか

- プロジェクトごとに環境変数を自動切り替え
- cdするだけで環境が整う
- .envrcはgitignoreに入れてローカル管理

### 設定例

```bash
# .envrc
export NOTION_API_KEY="secret-xxx"
export AWS_PROFILE="my-project"
```

### direnv + MCPの連携

1. プロジェクトディレクトリにcd
2. direnvが.envrcを読み込み
3. Claude Codeを起動
4. MCPサーバーが環境変数を参照

### 注意点

- `direnv allow` を忘れずに
- .envrcは.gitignoreに追加
- チームでは.envrc.exampleを共有

## MCPリソースの@メンション

```
@notion:page://xxx を見て
@github:issue://123 を確認して
```

## トラブルシューティング

- `claude --debug "mcp"` でデバッグ
- MCP_TIMEOUT環境変数でタイムアウト調整
- `/doctor` でMCP接続状態確認
