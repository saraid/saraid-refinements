module Saraid
  module Refinements
    module Blankable
      refine Object do
        def blank?
          nil? || (respond_to?(:empty?) && empty?)
        end

        def present?
          !blank?
        end

        def if_blank(&block)
          if blank? then block.call else self end
        end
      end
    end
  end
end
