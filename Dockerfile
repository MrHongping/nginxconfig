FROM bitnami/git as git
WORKDIR /app/
RUN git clone https://github.com/MrHongping/nginxconfig.git 

FROM node:16.18.1-alpine3.17 as node
WORKDIR /app/
COPY --from=git /app/nginxconfig /app
RUN npm ci \
	&& npm run build
FROM nginx
LABEL MAINTAINER="hongping@hongpinglei@gmail.com"
COPY --from=node /app/dist/ /usr/share/nginx/html/
EXPOSE 80
ENTRYPOINT ["nginx","-g","daemon off;"]
