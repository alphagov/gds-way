require 'listen'

module Listen
  module Adapter
    class << self
      def select(_options = {})
        # Force listener into polling mode, as inotifywait watcher is broken in podman: https://github.com/containers/podman/discussions/19430
        Adapter::Polling
      end
    end
  end
end
