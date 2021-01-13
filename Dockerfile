FROM elixir:latest

RUN apt-get update && \
    apt-get install -y mariadb-client && \
    apt-get install -y inotify-tools && \
    mix local.hex --force && \
    mix archive.install hex phx_new 1.5.7 --force && \
    mix local.rebar --force

ENV APP_HOME /app
WORKDIR $APP_HOME

#CMD ["mix", "phx.server"]
CMD printenv && ls -la && \
    mix deps.get --only prod && \
    mix ecto.up && \
    mix phx.server
