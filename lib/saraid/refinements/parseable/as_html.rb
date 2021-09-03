module Saraid
  module Refinements
    module Parseable
      module AsHtml
        refine String do
          def parse_as_html
            require 'oga'
            Oga.parse_html(self)
          end
        end

        if defined?(RestClient)
          refine RestClient::Response do
            def parse_as_html
              body.parse_as_html
            end
          end
        end
      end
    end
  end
end

