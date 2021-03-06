FROM node:10

WORKDIR /app

COPY package.json /app

RUN npm install express --save

COPY . /app


EXPOSE 80

CMD ["node", "index.js"]
