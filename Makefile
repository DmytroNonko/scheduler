DOCKER_COMPOSE=docker compose

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

restart: down up

bash:
	$(DOCKER_COMPOSE) exec php bash
