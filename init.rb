require "config/heroku/command/d2l"

begin
  require "heroku-api"
rescue LoadError
  puts <<-MSG
  heroku-d2l - requires the heroku-api gem. Please install:

  gem install heroku-api
  MSG
  exit
end
