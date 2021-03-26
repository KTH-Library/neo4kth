#! make

build:

	docker build --load -t kthb/neo4kth n10s

up:
	mkdir -p vols && docker-compose up -d

down:
	docker-compose down

browse:
	sleep 5 && firefox http://localhost:7474/ &
