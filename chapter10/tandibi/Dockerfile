FROM ruby:2.6.5
RUN gem install bundler:2.1.4

ENV LANG C.UTF-8
ENV APP_ROOT /tandibi

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg \
  | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" \
  | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev libssl1.1 \
  yarn nodejs libssl-dev postgresql-client screen

RUN mkdir -p ${APP_ROOT}
WORKDIR ${APP_ROOT}
COPY . ${APP_ROOT}

# Script to be executed every time the container starts.
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

# Install Google Chrome
RUN curl -sS -o - https://dl-ssl.google.com/\
linux/linux_signing_key.pub | apt-key add -

RUN echo "deb http://dl.google.com/\
linux/chrome/deb/ stable main" >> \
/etc/apt/sources.list.d/google-chrome.list

RUN apt-get -yqq update && \
apt-get -yqq install google-chrome-stable && \
rm -rf /var/lib/apt/lists/*
