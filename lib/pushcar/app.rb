require 'singleton'
module Pushcar
  class App
    include Singleton
    ASYNC_CALLBACK = "async.callback".freeze
    
    AsyncResponse = [-1, {}, []].freeze
    
    attr_reader :ping_interval
    
    def initialize
      @ping_interval = 5
      @started = false
    end
    
    def publish(channel, message)
      on_start unless @started
      Channel::InMemory.instance.publish channel, message
    end
    
    def subscribe(request, channel, session)
      on_start unless @started
      puts "Connection on channel #{channel} from #{session}"
      
      transport = Transport['default'].new(request)

      transport.on_close { puts "Connection closed on channel #{channel} from #{session}" }
      
      Channel::InMemory.instance.subscribe channel, session, transport

      EM.next_tick { request.env[ASYNC_CALLBACK].call transport.render }
    end
    
    private
    def on_start
      EM.add_periodic_timer(@ping_interval) { Transport.ping_all }
      @started = true
    end
  end
end
