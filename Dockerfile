FROM ruby:2.6.4

# Install capybara-webkit deps
RUN apt-get update \
    && apt-get install -y xvfb git cron qt5-default libqt5webkit5-dev \
    gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x \
    imagemagick

# Use JEMALLOC instead
# RUN apt-get install -y libjemalloc2 libjemalloc-dev
# ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

# Install our dependencies and rails
RUN gem update --system --force
RUN gem install bundler
RUN gem install rails
RUN mkdir -p /home/sotldirectory

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# ENV RAILS_ENV development
# ENV RACK_ENV development

WORKDIR /home/sotldirectory
ADD . /home/sotldirectory
# RUN bundle update --bundler
RUN bundle install --jobs=4 --retry=3

# Run bundle clean to get rid of duplicate gems
# RUN bundle clean --force
RUN yarn install

# Copy openssl config to correct folder
RUN cp -R openssl.cnf /etc/ssl 

ADD ./startup.sh /usr/bin/
RUN chmod -v +x /usr/bin/startup.sh
ENTRYPOINT ["/usr/bin/startup.sh"]