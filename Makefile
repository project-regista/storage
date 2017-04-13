.DEFAULT_GOAL := help

PROJECT_NAME := regista
IMAGE_NAME := neo4j

NEO4J_CONTAINER_NAME := neo4j-"${PROJECT_NAME}"
NEO4J_HTTP_PORT := 7474
NEO4J_BOLT_PORT := 7687
NEO4J_DATA_VOLUME := "${PWD}"/data

.PHONY: help neo4j/start

help:
	@echo "------------------------------------------------------------------------"
	@echo "${PROJECT_NAME}"
	@echo "------------------------------------------------------------------------"
	@grep -E '^[a-zA-Z0-9_/%\-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

neo4j/start: ## Start Neo4j instance
	@printf "Starting '"${NEO4J_CONTAINER_NAME}"' container using HTTP port: %s and BOLT port:%s\n" \
	"${NEO4J_HTTP_PORT}" "${NEO4J_BOLT_PORT}"
	@printf "It will create a Neo4j data directory at '"${PWD}"' if it does not exist.\n"
	@docker run \
	-d \
	--publish="${NEO4J_HTTP_PORT}":"${NEO4J_HTTP_PORT}" \
	--publish="${NEO4J_BOLT_PORT}":"${NEO4J_BOLT_PORT}" \
	--volume="${NEO4J_DATA_VOLUME}":/data \
	--name "${NEO4J_CONTAINER_NAME}" \
	neo4j
