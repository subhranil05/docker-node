VERSION 			?= dev
REPO_NAME           ?= subhranil05
IMG_NAME            ?= webapp-node
IMG 				?= REPO_NAME/IMG_NAME:$(VERSION)
LATEST_IMG			?= REPO_NAME/IMG_NAME:latest
EXPERIMENTAL_TAG	?= $(VERSION)-exp


.PHONY: setup-dev
setup-dev:
	touch webapp-dev.env		

.PHONY: setup-prod
setup-prod:
	touch webapp-prod.env

.PHONY: setup-local
setup-local:
	npm init -y
	npm install express
	npm install nodemon --save-dev
	npm install mongoose
	touch mongo.env

.PHONY: start-server
start-server:
	node index.js

.PHONY: docker-dev
docker-dev:
	docker build --no-cache \
	--progress auto \
	--build-arg NODE_ENV=development \
	-t ${IMG} \
	-f ./Dockerfile .

.PHONY: docker-prod
docker-prod:
	docker build --no-cache \
	--progress auto \
	--build-arg NODE_ENV=production \
	-t $REPO_NAME/IMG_NAME:prod \
	-f ./Dockerfile .

.PHONY: push
push:
	docker push ${IMG}

.PHONY: compose
compose:
	docker-compose -f ./docker-compose.yaml up -d --remove-orphans

.PHONY: dev-compose
dev-compose:
	docker-compose -f ./docker-compose-dev.yaml up -d --remove-orphans


.PHONY: prod-compose
prod-compose:
	docker-compose -f ./docker-compose-prod.yaml up -d --remove-orphans

.PHONY: clean
clean:
	docker-compose -f ./docker-compose.yaml down

.PHONY: clean-all
clean-all:
	docker-compose -f ./docker-compose.yaml down -v