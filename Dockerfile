FROM ruby:3.1

ARG BUNDLER_VERSION=2.3.20
ARG APP_DIR=/opt/app
ARG USER=ruby
ARG GROUP=ruby

ENV RAILS_ENV=production

RUN getent group $GROUP || groupadd --system $GROUP
RUN useradd --system --gid $GROUP --create-home $USER

RUN mkdir $APP_DIR && chown -R $USER:$GROUP $APP_DIR
RUN gem install bundler --no-document --version $BUNDLER_VERSION

USER $USER
WORKDIR $APP_DIR

COPY --chown=$USER:$GROUP . .

RUN bundle config set frozen 1 \
    && bundle config deployment 'true' \
    && bundle config without 'development test' \
    && bundle config --local path 'gems' \
    && bundle install -j4 --retry 3 \
    && rm -rf cache/*.gem \
    && find gems/ -name '*.c' -delete \
    && find gems/ -name '*.o' -delete

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
