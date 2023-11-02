#!make
.PHONY: staging prod dev prod-monitoring down down-prod down-staging down-dev wipe logs config status logic app

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
	@docker compose -f docker-compose.yaml -f docker-compose.dev.yaml --profile monitoring up -d --build --remove-orphans 

down: 
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml --profile monitoring down

staging-down: 
	@docker compose down

prod-down:
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml down

prod-monitoring-down:
	@docker compose -f docker-compose.yaml -f docker-compose.prod.yaml --profile monitoring down

dev-down:
	@docker compose -f docker-compose.yaml -f docker-compose.dev.yaml --profile monitoring down

logs: 
	@docker compose logs -f 

wipe:	
	@docker images -a | xargs docker rmi 
	@docker system prune -af --volumes  
	@docker volume prune

config:
	@docker compose exec --workdir /data/config logic git pull

logic:
	@docker compose exec --workdir /data/projects/logic logic git pull
	@docker compose restart logic

app:
	@docker compose exec --workdir /usr/share/nginx/html/client app git pull

status:
	wget -O - http://localhost/api/v1/status