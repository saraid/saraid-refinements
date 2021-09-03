module Saraid
  module Refinements
    module Loggable
      def self.logger_instance
        @logger_instance ||=
          begin
            require 'logger'
            Logger.new($stderr)
          end
      end

      def self.logger_instance=(logger)
        @logger_instance = logger
      end

      refine Object do
        private def logger
          Saraid::Refinements::Loggable.logger_instance
        end

        def log(level = :info, &block)
          tap { logger.send(level, block.call(self)) }
        end

        def log_debug(&block)
          log(:debug, &block)
        end

        def log_info(&block)
          log(:info, &block)
        end

        def log_warn(&block)
          log(:warn, &block)
        end

        def log_error(&block)
          log(:error, &block)
        end
      end
    end
  end
end
