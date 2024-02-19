DEFAULT_GOAL := help 

lint: ## Run chart-tester lint
	@docker run -it --rm --workdir=/data --volume $(shell pwd)/ct.yaml:/ct.yaml --volume ~/.kube/config:/root/.kube/config:ro --volume $(shell pwd):/data quay.io/helmpack/chart-testing:v3.10.1 ct lint --all --config /ct.yaml 

docs: ## Run helm-docs
	@docker run --rm -v $(shell pwd):/helm-docs -u $(shell id -u):$(shell id -g) jnorwood/helm-docs:latest

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'