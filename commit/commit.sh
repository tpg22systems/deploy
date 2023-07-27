for c in tpg22-control-build-app cturra/ntp tpg22-control-build-couchdb stoplight/prism tpg22-control-build-editor tpg22-control-build-logic eclipse-mosquitto
do
	docker container commit $(docker container ls | grep $c | cut -d " " -f1) $c:latest
	docker image tag $c:latest docker.camart.co.uk:5000/$c:latest
	docker image push docker.camart.co.uk:5000/$c:latest
done
