require "faraday"
require "netrc"
require "json"
require "heroku/command/base"

class Heroku::Command::D2L < Heroku::Command::Base

  # d2l:list
  #
  # List all the measurements currently active
  #
  def list
    puts JSON.pretty_generate(client.get('/measurements').body)
  end

  def add
    puts 'add'
  end

  def update
    puts 'update'
  end

  private

  def client
    @client ||= Faraday.new(:url => 'http://libraclips.herokuapp.com').tap do |conn|
      conn.basic_auth(credentials[0], credentials[1])
    end
  end

  def credentials
    @creds ||= Netrc.read['libraclips.herokuapp.com']
  end
end

