up:
	- docker run -d --name mongo -p 27017:27017 -v=/data/db:/data/db mongo --dbpath /data/db --port 27017 --replSet rs0 --storageEngine wiredTiger
	- docker run -d --name elasticsearch -p 9200:9200 elasticsearch -Des.network.host=0.0.0.0
	- docker run -d --name kibana --link=elasticsearch:elasticsearch -p 5601:5601 kibana
	- sleep 1
	- docker run -d --name mongo_connector --link=mongo:mongo --link=elasticsearch:elasticsearch yeasy/mongo-connector

	docker run -d --name mongo_connector --env=MONGO=api-staging.theweflex.com:27017 --link=elasticsearch:elasticsearch yeasy/mongo-connector

down:
	- docker kill mongo_connector
	- docker kill kibana
	- docker kill elasticsearch
	- docker kill mongo
	
clear: down
	- docker rm mongo_connector
	- docker rm kibana
	- docker rm elasticsearch
	- docker rm mongo
