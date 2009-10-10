require 'singleton'
module Pushcar
  module Channel
    class InMemory
      include Singleton
      attr_accessor :queues
      
      def initialize
        @queues = Hash.new
      end
      
      def unsubscribe(channel_id, session_id)
        queues[channel_id].delete session_id
      end
      
      def subscribe(channel_id, session_id, transport)
        queues[channel_id] ||= {}
        queues[channel_id][session_id] ||= []
        queues[channel_id][session_id] << transport
        transport.on_close { unsubscribe channel_id, session_id }
      end
      
      def publish(channel_id, message)
        queues[channel_id].each{|sid, transports| transports.each{|e| e.write message } }
      end
    end
  end
end