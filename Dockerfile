FROM ruby:2.6.2

# Install capybara-webkit deps
RUN apt-get update \
    && apt-get install -y xvfb git cron qt5-default libqt5webkit5-dev \
                          gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x \
                          imagemagick

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

# Install our dependencies and rails
RUN \
    gem install bundler \
    && gem install rails \
    && mkdir -p /home/tlcdirectory
    
WORKDIR /home/tlcdirectory
ADD . /home/tlcdirectory
RUN bundle install --jobs=4 --retry=3

ADD ./startup.sh /usr/bin/
RUN chmod -v +x /usr/bin/startup.sh
ENTRYPOINT ["/usr/bin/startup.sh"]