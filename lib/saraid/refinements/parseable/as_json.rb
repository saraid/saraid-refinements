module Saraid
  module Refinements
    module Parseable
      module AsJson
        refine String do
          require 'json'

          def parse_as_json
            JSON.parse(self, symbolize_names: true)
          end
        end

        if defined?(RestClient)
          refine RestClient::Response do
            def parse_as_json
              body.parse_as_json
            end
          end
        end
      end
    end
  end
end
