# docker-node
Building dev/prod workflow with docker and Node.js

## Makefile steps
To setup locally
```sh
make setup-local
```
To start server locally
```sh
make start-server
```
To build Docker image in dev/prod
```sh
make docker-dev
make docker-prod

To push Docker image to docker hub repo
```sh
make push
```
## steps:

### create package.json file
```sh
npm init -y
```
### Get express dependecies
```sh
npm install express
```
### create webapp on index.js

### start the webapp
```sh
node index.js
```

### After testing successfully in local setup, lets start making  dockerize this app
Create Dockerfile

### build docker image
```sh
docker build -t subhranil05/express-node-app:0.0.1 
```

### run docker image
```sh
docker run -p 3000:3000 subhranil05/express-node-app:0.0.1
```

### volume binding
```sh
docker run -d -v $(pwd):/app -p 3000:3000 subhranil05/express-node-app:0.0.1
```

### install nodemon in dev env to restart node process whenever code chnages
```sh
npm install nodemon --save-dev
```

### create script in package.json for commands
```shell
"scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js"
  },
```

### prevent to overwriting nodemodules dir indie container during local volume binding
```sh
docker run -d -v $(pwd):/app -v /app/node_modules -p 3000:3000 subhranil05/express-node-app:0.0.2
```
### making container path read-only
```sh
docker run -d -v $(pwd):/app:ro -v /app/node_modules -p 3000:3000 subhranil05/express-node-app:0.0.2
```
### docker container login
```sh
docker exec -it <container_name> sh/bash
```

### pass env vraible with docker run command
```sh
docker run -d -v $(pwd):/app:ro -v /app/node_modules -e PORT=4000 -p 3000:4000 subhranil05/express-node-app:0.0.2
```

### pass env file instead of single variable
```sh
docker run -d -v $(pwd):/app:ro -v /app/node_modules --env-file ./env -p 3000:4000 subhranil05/express-node-app:0.0.2
```
### Start a docker compose file
```sh
docker-compose up -d
```

### stop compose services
```sh
docker-compose down
```

### Add mongdb container to docker compose

### Use mongo env variable in mongo.env local file

### Steps to connect to mongodb
```shell
docker exec -it <container_name> bash
mongosh -u "user_name" -p "password"

# mongo commands after connection to db

db  # list current db
show dbs # list of databases present
use mydb # switched to db mydb

db.books.insert({"name": "Harry Potter"}) # insert data to mydb

db.books.find() # show inserted data
```
### You can directly use below command also to login to database
```shell
docker exec -it <container_name> mongosh -u "user_name" -p "password"
```
### intsall mongoose package
```sh
npm install mongoose
```
### use https://www.npmjs.com/package/mongoose to implement mongoose in index.js

use docker inspect to get the ipaddress of mongo container and add it to host

```sh
docker-compose clean-up with volume
docker-compose down -v
```