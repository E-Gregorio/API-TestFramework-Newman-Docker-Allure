FROM node:16-alpine


RUN apk add --no-cache openjdk11-jre


WORKDIR /app


COPY package*.json ./
COPY JSONPlaceholder-CRUD.postman_collection.json ./


RUN npm install -g newman allure-commandline && \
	npm install && \
	mkdir -p allure-results


CMD ["npm", "test"]