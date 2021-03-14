FROM ruby:3

RUN apt update && apt upgrade -y
RUN gem install bundler
RUN apt install -y python3-pip python3-setuptools dos2unix
WORKDIR /src
COPY Gemfile* *.gemspec /src/
RUN bundle install
CMD ["/bin/bash"]