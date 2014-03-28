require "config/heroku/command/d2l"

begin
  require "heroku-api"
  require "netrc"
  require "farady"
rescue LoadError
  puts <<-MSG
  heroku-d2l - requires the some gems. Please install:

  gem install heroku-api
  gem install faraday
  gem install netrc
  MSG
  exit
end
