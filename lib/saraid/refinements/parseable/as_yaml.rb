module Saraid
  module Refinements
    module Parseable
      module AsYaml
        refine String do
          require 'yaml'

          def parse_as_yaml(symbolize_names = true)
            YAML.load(self, symbolize_names: symbolize_names)
          end
        end

        if defined?(RestClient)
          refine RestClient::Response do
            def parse_as_yaml(symbolize_names = true)
              body.parse_as_yaml(symbolize_names)
            end
          end
        end
      end
    end
  end
end
