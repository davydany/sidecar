build:
	docker build . -t davydany/sidecar;

build-and-run:
	docker build . -t davydany/sidecar;
	docker run -it davydany/sidecar:latest bash

up:
	docker compose up --build -d;

down:
	docker compose down --remove-orphans;

exec:
	docker compose exec -it sidecar /bin/bash;
