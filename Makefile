build:
	docker-compose build
up:
	docker-compose up
start:
	docker-compose up -d
down:
	docker-compose down
logs:
	docker-compose logs -f app
bash:
	docker-compose run --rm app bash $(cmd)
bundle:
	make bash cmd='bundle exec $(cmd)'
rake:
	make bundle cmd='rake $(cmd)'
init:
	make rake cmd='db:drop db:create db:migrate db:seed'