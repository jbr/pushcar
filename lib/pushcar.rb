require "eventmachine"
Dir[File.dirname(__FILE__) + "/pushcar/**/*"].each {|file| require file}
module Pushcar
end