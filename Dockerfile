FROM ruby:2.6.5
MAINTAINER Paweł Bielicki

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
WORKDIR app
RUN bundle install

COPY . /app
ARG IPSTACK_API_KEY

ENV GEODB_DATABASE_USERNAME=postgres
ENV GEODB_DATABASE_PASSWORD=postgres
ENV IPSTACK_API_KEY=${IPSTACK_API_KEY}

CMD ["bundle", "exec", "rails", "s", "--binding", "0.0.0.0"]

EXPOSE 3000
