FROM crystallang/crystal

RUN apt-get update && apt-get install -y libpq-dev postgresql-client wait-for-it

WORKDIR /app

COPY shard.yml shard.lock ./

RUN shards install

COPY . .

CMD bash -c "wait-for-it -t 30 database:5432 && crystal sam.cr db:create && crystal sam.cr db:migrate && crystal run src/travelsapi.cr"

EXPOSE 3000
