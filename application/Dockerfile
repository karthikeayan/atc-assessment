FROM node:17.4-alpine3.15

WORKDIR /app

COPY package*.json .

RUN npm install

COPY index.js .

CMD ["node", "index.js"]
