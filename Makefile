dev: ## Run dev environment
	gleam run -m lustre/dev start

gen_css: ## Generate css
	gleam run -m sketch/css generate

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
