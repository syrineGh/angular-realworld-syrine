FROM node:16.13-alpine as builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run ng build

FROM nginx:alpine

WORKDIR /usr/share/nginx/html
RUN rm -rf ./*

COPY --from=builder /app/dist /app

ENV NODE_ENV=production

ENTRYPOINT [ "nginx" , "-g", "daemon off;" ]

