require 'netrc'
require 'json'
require 'net/http'
require 'heroku/command/base'

class Heroku::Command::D2L < Heroku::Command::Base

  # list
  #
  # List all the measurements currently active
  #
  def list
    uri = URI(base_url)
    req = Net::HTTP::Get.new(uri.request_uri)
    execute_and_print(req)
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
    uri = URI(base_url)
    req = Net::HTTP::Post.new(uri.path)
    body = prepare_body(dataclip_reference)
    execute_and_print(req, body)
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
    uri = URI("#{base_url}#{id}")
    req = Net::HTTP::Patch.new(uri.path)
    body = prepare_body(dataclip_reference)
    execute_and_print(req, body)
  end

  private

  def execute_and_print(req, body = nil)
    if body
      req.body = body.to_json
      req['Content-Type'] = 'application/json'
    end
    req.basic_auth *creds
    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }
    puts JSON.pretty_generate(JSON.parse(res.body))
  end

  def prepare_common_body(dataclip_reference)
    librato_base_name = options[:librato]
    librato_source = options[:source]
    run_interval = options[:interval]
    body = {}
    body[:dataclip_reference] = dataclip_reference if dataclip_reference
    body[:dataclip_reference] = dataclip_reference if dataclip_reference
    body[:librato_base_name] = librato_base_name if librato_base_name
    body[:librato_source] = librato_source if librato_source
    body[:run_interval] = run_interval if run_interval
    body
  end

  def creds
    Netrc.read['libraclips.herokuapp.com']
  end

  def base_url
    'http://libraclips.herokuapp.com/measurements'
  end
end

