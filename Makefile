#!make
.PHONY: staging prod dev down down-prod down-dev wipe logs

prod:
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml up -d --remove-orphans

staging:
	@docker compose up -d  --remove-orphans

dev:
	@docker compose -f docker-compose.yaml -f docker-compose.dev.yaml up -d --build --remove-orphans

down: 
	@docker compose down

prod-down:
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml down

dev-down:
	@docker compose -f docker-compose.yaml -f docker-compose.dev.yaml down

logs: 
	@docker compose logs -f 

wipe:
# clear all local containers
	@docker ps -aq | xargs docker stop | xargs docker rm



