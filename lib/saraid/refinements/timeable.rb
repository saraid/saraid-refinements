require_relative './loggable'

module Saraid
  module Refinements
    module Timeable
      include Loggable

      def self.time(label = '', level = :debug)
        start = begin_timer(label, level)
        yield.tap do
          elapsed = now - start
          instance.send(level, "[#{label}] Elapsed: #{"%.2f" % elapsed}s")
        end
      end

      def self.timer_start(label, level = :debug)
        timers[label] = { time: begin_timer(label, level), level: level }
      end

      def self.timer_end(label)
        elapsed = now - timers.fetch(label)
        instance.send(timers.fetch(label)[:level], "[#{label}] Elapsed: #{"%.2f" % elapsed}s")
      end

      private_class_method def self.timers
        @timers ||= {}
      end

      private_class_method def self.now
        Process.clock_gettime(Process::CLOCK_MONOTONIC)
      end

      private_class_method def self.begin_timer(label, level)
        instance.send(level, "[#{label}] Starting") # if log beginning
        now
      end

      refine Object do
        def timer_start(label, level = :debug)
          tap { logger.respond_to?(:timer_start) && timer_start(label, level) }
        end

        def timer_end(label, level = :debug)
          tap { logger.respond_to?(:timer_start) && timer_end(label, level) }
        end
      end
    end
  end
end
