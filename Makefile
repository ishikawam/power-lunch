.DEFAULT_GOAL := help
.PHONY: help html pdf preview open lint clean

# 開催済みスライド: lunches/01/, lunches/02/ など
SESSIONS := $(wildcard lunches/[0-9][0-9]/slide.md)
# アイデアスライド
IDEAS := $(wildcard ideas/slides/*.md)
# 全スライド
SLIDES := $(SESSIONS) $(IDEAS)

help: ## ヘルプ表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

html: ## 全スライドをHTMLに変換
	@for slide in $(SLIDES); do \
		dir=$$(dirname "$$slide"); \
		name=$$(basename "$$slide" .md); \
		mkdir -p "dist/$$dir"; \
		output="dist/$$dir/$$name.html"; \
		echo "Building $$output..."; \
		npx @marp-team/marp-cli "$$slide" -o "$$output"; \
	done

pdf: ## 全スライドをPDFに変換
	@for slide in $(SLIDES); do \
		dir=$$(dirname "$$slide"); \
		name=$$(basename "$$slide" .md); \
		mkdir -p "dist/$$dir"; \
		output="dist/$$dir/$$name.pdf"; \
		echo "Building $$output..."; \
		npx @marp-team/marp-cli "$$slide" -o "$$output"; \
	done

preview: ## スライドを選択してプレビュー
	@echo "プレビューするスライドを選択:"; \
	select slide in $(SLIDES) "キャンセル"; do \
		if [ "$$slide" = "キャンセル" ]; then \
			echo "キャンセルしました"; \
			break; \
		elif [ -n "$$slide" ]; then \
			npx @marp-team/marp-cli -p "$$slide"; \
			break; \
		fi; \
	done

open: ## スライドを選択してHTMLを開く
	@echo "開くスライドを選択:"; \
	select slide in $(SLIDES) "キャンセル"; do \
		if [ "$$slide" = "キャンセル" ]; then \
			echo "キャンセルしました"; \
			break; \
		elif [ -n "$$slide" ]; then \
			dir=$$(dirname "$$slide"); \
			name=$$(basename "$$slide" .md); \
			html="dist/$$dir/$$name.html"; \
			if [ ! -f "$$html" ]; then \
				mkdir -p "dist/$$dir"; \
				echo "HTMLを生成中..."; \
				npx @marp-team/marp-cli "$$slide" -o "$$html"; \
			fi; \
			open "$$html"; \
			break; \
		fi; \
	done

lint: ## Markdownをリント・自動修正
	@npx markdownlint-cli --fix $(SLIDES) ideas/docs/*.md lunches/[0-9][0-9]/*.md 2>/dev/null || true

clean: ## 生成ファイル削除
	rm -rf dist/
