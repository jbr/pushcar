module Pushcar
  module ControllerMethods
    def subscribe_to(channel, options = {})
      identifier = options[:as] || session[:session_id]
      Pushcar::App.instance.subscribe request, channel, identifier
      render :status => -1, :nothing => true
    end

    def render_push(options)
      unless channel = options.delete(:channel)
        raise "render_push requires a channel"
      end
      
      Pushcar::App.instance.publish channel, render_to_string(options)
    end
  end
end