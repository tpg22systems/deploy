#!make
.PHONY: staging prod dev prod-monitoring down down-prod down-staging down-dev wipe logs cache-images

prod:
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml pull
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml up -d --remove-orphans

prod-monitoring:
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml pull
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml --profile monitoring up -d --remove-orphans  


staging:
	@docker compose pull
	@docker compose up -d  --remove-orphans

dev:
	@docker compose -f docker-compose.yaml -f docker-compose.dev.yaml up -d --build --remove-orphans

down: 
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml down

staging-down: 
	@docker compose down

prod-down:
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml down

prod-monitoring-down:
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml --profile monitoring down

dev-down:
	@docker compose -f docker-compose.yaml -f docker-compose.dev.yaml down

logs: 
	@docker compose logs -f 

wipe:	
	@docker images -a | xargs docker rmi 
	@docker system prune -af --volumes  
	@docker volume prune

