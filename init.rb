Dir[File.join(File.expand_path("../vendor", __FILE__), "*")].each do |vendor|
    $:.unshift File.join(vendor, "lib")
end

require "config/heroku/command/d2l"
