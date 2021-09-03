module Saraid
  module Refinements
    module ForArray
      refine Array do
        def unwrap(&block)
          if block_given? && respond_to?(:yield_self)
            size > 1 ? yield_self(&block) : first
          elsif size > 1
            raise RangeError, "Expected #{self.class} to have only one element, but it has #{size} elements."
          else
            first
          end
        end

        def expand(&block)
          zip(map(&block)).to_h
        end
      end
    end
  end
end
