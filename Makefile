.PHONY: staging prod dev down down-prod down-dev wipe
staging:
	@docker compose up -d

prod:
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml up -d

dev:
	@docker compose -f docker-compose.yaml -f docker-compose.dev.yaml up -d --build

down: 
	@docker compose down

prod-down:
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml down

dev-down:
	@docker compose -f docker-compose.yaml -f docker-compose.dev.yaml down

wipe:
# clear all local containers
	@docker ps -aq | xargs docker stop | xargs docker rm

