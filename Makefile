up: ## Start docker containers
	docker-compose up

upd: ## Start docker containers in detached mode
	docker-compose up -d

build: ## Build docker image
	docker-compose build

buildf: ## Build docker image with no cache
	docker-compose build --no-cache

dev: ## Run dev environment
	make gen_css
	gleam run -m lustre/dev start

gen_css: ## Generate css
	gleam run -m sketch/css generate

help: ## Show this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
