FROM ruby
RUN apt-get -y update && apt-get -y install libicu-dev cmake && rm -rf /var/lib/apt/lists/*

WORKDIR /apps
COPY Gemfile /apps/Gemfile
RUN bundle install 
CMD ["unicorn", "-c", "unicorn.rb"]
EXPOSE 80
