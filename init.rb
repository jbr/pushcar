require 'pushcar'
Mime::Type.register "text/javascript", :push
# ActionController::Dispatcher.middleware.use Pushcar::App

ActionController::Base.class_eval do
  include Pushcar::ControllerMethods
end
