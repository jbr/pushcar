module Pushcar
  module Transport
    OPENED = []
    BACKENDS = {}
    
    def self.select(transport)
      BACKENDS[transport] || BACKENDS["default"]
    end
    
    class << self
      alias_method :[], :select
    end
    
    def self.ping_all
      OPENED.each { |transport| transport.renderer.call [" "] }
    end
  end
end