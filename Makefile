.DEFAULT_GOAL := help
.PHONY: help html pdf preview open lint fix clean

SLIDES := 01/slide.md $(wildcard ideas/slides/*.md)

help: ## ヘルプ表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

html: ## 全スライドをHTMLに変換
	@for slide in $(SLIDES); do \
		if echo "$$slide" | grep -q "^ideas/slides/"; then \
			num=$$(echo "$$slide" | sed 's/ideas\/slides\/\([0-9]*\)_.*/\1/'); \
			mkdir -p "dist/$$num"; \
			output="dist/$$num/slide.html"; \
		else \
			output=$${slide%.md}.html; \
		fi; \
		echo "Building $$output..."; \
		npx @marp-team/marp-cli "$$slide" -o "$$output"; \
	done

pdf: ## 全スライドをPDFに変換
	@for slide in $(SLIDES); do \
		if echo "$$slide" | grep -q "^ideas/slides/"; then \
			num=$$(echo "$$slide" | sed 's/ideas\/slides\/\([0-9]*\)_.*/\1/'); \
			mkdir -p "dist/$$num"; \
			output="dist/$$num/slide.pdf"; \
		else \
			output=$${slide%.md}.pdf; \
		fi; \
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
			if echo "$$slide" | grep -q "^ideas/slides/"; then \
				num=$$(echo "$$slide" | sed 's/ideas\/slides\/\([0-9]*\)_.*/\1/'); \
				html="dist/$$num/slide.html"; \
				if [ ! -f "$$html" ]; then \
					mkdir -p "dist/$$num"; \
					echo "HTMLを生成中..."; \
					npx @marp-team/marp-cli "$$slide" -o "$$html"; \
				fi; \
			else \
				html=$${slide%.md}.html; \
				if [ ! -f "$$html" ]; then \
					echo "HTMLを生成中..."; \
					npx @marp-team/marp-cli "$$slide" -o "$$html"; \
				fi; \
			fi; \
			open "$$html"; \
			break; \
		fi; \
	done

lint: ## Markdownをリント
	@npx markdownlint-cli $(SLIDES) ideas/docs/*.md 01/*.md || true

fix: ## Markdownを自動修正
	@npx markdownlint-cli --fix $(SLIDES) ideas/docs/*.md 01/*.md || true

clean: ## 生成ファイル削除
	rm -rf dist/
	rm -f 01/*.html 01/*.pdf
