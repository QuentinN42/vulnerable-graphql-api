FROM ubuntu:18.04
LABEL org.opencontainers.image.authors="aidan.noll@carvesystems.com"
LABEL org.opencontainers.image.maintainer="quentin@escape.tech"

RUN apt-get update && apt-get install -y nodejs npm python3 sqlite3

RUN useradd -m app
USER app

COPY --chown=app . /home/app/app

RUN cd /home/app/app && npm install sqlite3 && npm install && npm run tsc && npm run sequelize db:migrate && npm run sequelize db:seed:all

CMD cd /home/app/app && ./run.sh
