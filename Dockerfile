### STAGE 1:BUILD ###
FROM node:18.16.0-alpine3.18 AS build
# Set working directory path inside docker image
WORKDIR /dist/src/app

RUN npm cache clean --force

COPY . .
RUN npm install
RUN npm run build --prod


### STAGE 2:RUN ###
# Defining nginx image to be used
FROM nginx:latest AS ngi
# Copying compiled code and nginx config to different folder

COPY --from=build /dist/src/app/dist/angular-nginx-docker/browser /usr/share/nginx/html
COPY /nginx.conf  /etc/nginx/conf.d/default.conf

EXPOSE 80