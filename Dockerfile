FROM node:19 as build

ENV NODE_ENV=production 


WORKDIR /app

COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . ./
RUN npm run build


FROM node:19-alpine3.16

WORKDIR /app
COPY --from=build /app .


ENV HOST=0.0.0.0
EXPOSE 3005

CMD ["npm","run", "dev","--", "--host", "0.0.0.0"]