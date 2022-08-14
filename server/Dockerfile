FROM node:18.0-alpine as development
WORKDIR /usr/src/app

FROM node:18-alpine as production
WORKDIR /usr/src/app
COPY ["package*.json",  "package-lock.json" ,"./"]
RUN yarn
COPY ./dist/ /usr/src/app/dist/
EXPOSE 5000
CMD ["node", "dist/main"]