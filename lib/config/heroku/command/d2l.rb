require 'json'
require 'net/http'
require 'heroku/command/base'

class Heroku::Command::D2L < Heroku::Command::Base

  # list
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
    puts JSON.pretty_generate(JSON.parse(res.body))
  end

  # add [dataclip]
  #
  # Add a measurment for dataclip
  #
  #
  # -l, --librato  BASENAME  # specify librato base name
  # -s, --source   LIBRATOSOURCE # the source
  # -i, --interval RUNINTERVAL # the interval
  #
  def add
    dataclip_reference = shift_argument
    validate_arguments!
    librato_base_name = options[:librato]
    librato_source = options[:source]
    run_interval = options[:interval]
    uri = URI('http://libraclips.herokuapp.com/measurements')
    req = Net::HTTP::Post.new(uri.path)
    req.basic_auth 'tools', 'team'
    req['Content-Type'] = 'application/json'
    body = {}
    body[:dataclip_reference] = dataclip_reference if dataclip_reference
    body[:librato_base_name] = librato_base_name if librato_base_name
    body[:librato_source] = librato_source if librato_source
    body[:run_interval] = run_interval if run_interval
    req.body = body.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }
    puts JSON.pretty_generate(JSON.parse(res.body))
  end

  # update [id]
  #
  # Update a measurment for dataclip
  #
  #
  # -l, --librato  BASENAME  # specify librato base name
  # -s, --source   LIBRATOSOURCE # the source
  # -i, --interval RUNINTERVAL # the interval
  # -d, --dataclip DATACLIP # the dataclip
  #
  def update
    id = shift_argument
    validate_arguments!
    dataclip_reference = options[:dataclip]
    librato_base_name = options[:librato]
    librato_source = options[:source]
    run_interval = options[:interval]
    uri = URI("http://libraclips.herokuapp.com/measurements/#{id}")
    req = Net::HTTP::Patch.new(uri.path)
    req.basic_auth 'tools', 'team'
    req['Content-Type'] = 'application/json'
    body = {}
    body[:dataclip_reference] = dataclip_reference if dataclip_reference
    body[:librato_base_name] = librato_base_name if librato_base_name
    body[:librato_source] = librato_source if librato_source
    body[:run_interval] = run_interval if run_interval
    req.body = body.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }
    puts JSON.pretty_generate(JSON.parse(res.body))
  end
end

