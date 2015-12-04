build:
	touch docker-compose.yml
	(sed -e "s/%mongo%/${MONGO}/g" \
		-e "s/%mongo.username%/${MONGO_USERNAME}/g" \
		-e "s/%mongo.password%/${MONGO_PASSWORD}/g" < docker-compose.tmpl) > docker-compose.yml

clear:
	rm -rf docker-compose.yml

start: build
	docker-compose up
