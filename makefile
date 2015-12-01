
run:
	- docker run -d --name mongo -p 27017:27017 --volume=/data:/data mongo --port 27017 --replSet rs0 --storageEngine wiredTiger
	- docker run -d --name elasticsearch -p 9200:9200 elasticsearch -Des.network.host=0.0.0.0
	- docker run -d --name kibana --link=elasticsearch:elasticsearch -p 5601:5601 kibana
	- docker run -d --name mongo_connector --link=mongo:mongo --link=elasticsearch:elasticsearch yeasy/mongo-connector

fresh:
	- docker kill mongo_connector
	- docker kill kibana
	- docker kill elasticsearch
