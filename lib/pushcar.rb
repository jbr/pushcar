require "eventmachine"
Dir[File.dirname(__FILE__) + "/pushcar/**/*"].each {|file| require file}
module Pushcar
  def self.publish(*args)
    Pushcar::App.instance.publish *args
  end
  
  def self.subscribe(*args)
    Pushcar::App.instance.subscribe *args
  end
end