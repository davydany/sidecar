up:
	docker compose up --build -d

down:
    docker compose down --remove-orphans

exec:
    docker compose exec -it sidecar /bin/bash
