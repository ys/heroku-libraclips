require 'json'
require 'net/http'
require 'heroku/command/base'

class Heroku::Command::D2L < Heroku::Command::Base

  # d2l:list
  #
  # List all the measurements currently active
  #
  def list
    uri = URI('http://libraclips.herokuapp.com/measurements')
    req = Net::HTTP::Get.new(uri.request_uri)
    req.basic_auth 'tools', 'team'
    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
        http.request(req)
    }
    puts JSON.pretty_generate(res.body)
  end

  def add
    puts 'add'
  end

  def update
    puts 'update'
  end

  private

end

