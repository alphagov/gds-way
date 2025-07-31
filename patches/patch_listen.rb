require 'listen'

module Listen
  module Adapter
    class << self
      def select(_options = {})
        Listen.logger.debug 'Monkey patch: forcing polling adapter'
        Adapter::Polling
      end
    end
  end
end
