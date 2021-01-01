FROM node:alpine as build

WORKDIR /app

COPY . .
RUN sed -i "s@const API_ROOT = 'https://conduit.productionready.io/api'\;@const API_ROOT = 'http://localhost/api'\;@g" src/agent.js
RUN yarn install
RUN yarn build

FROM nginx:stable-alpine
COPY --from=build  /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]