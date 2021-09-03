module Saraid
  module Refinements
    module Duration
      refine Numeric do
        def seconds
          self
        end
        alias second seconds

        def minutes
          seconds * 60
        end
        alias minute minutes

        def hours
          minutes * 60
        end
        alias hour hours

        def days
          hours * 24
        end
        alias day days
      end
    end
  end
end
