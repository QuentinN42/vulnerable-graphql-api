FROM ubuntu:22.04
LABEL org.opencontainers.image.authors="aidan.noll@carvesystems.com"
LABEL org.opencontainers.image.maintainer="quentin@escape.tech"

RUN apt-get update && apt-get install -y nodejs npm python3 sqlite3

RUN useradd -m app
USER app
RUN mkdir -p /home/app/app
WORKDIR /home/app/app

COPY --chown=app package.json .

RUN npm install sqlite3 && npm install

COPY --chown=app . .

RUN npm run tsc
RUN npm run sequelize db:migrate
RUN npm run sequelize db:seed:all

CMD ./run.sh
