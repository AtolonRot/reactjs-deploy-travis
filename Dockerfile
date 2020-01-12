FROM node:alpine as builder

WORKDIR /usr/src/atolon-rot

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM mesosphere/aws-cli

COPY --from=builder /usr/src/atolon-rot .

CMD ["s3", "sync", "./", "s3://atolonrot-webapp"]