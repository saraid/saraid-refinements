module Saraid
  module Refinements
    module ForClass
      module Inspection
        refine Class do
          def saneify_inspection!
            class_eval do
              def inspect
                $stderr.puts 'inspect'
                postamble = ''
                if respond_to?(:inspectable_attributes)
                  postamble << inspectable_attributes
                    .map { |attr| "@#{attr}=#{instance_variable_get(:"@#{attr}").inspect}" }
                    .join(', ')
                    .prepend(' ')
                end
                if respond_to?(:custom_inspection)
                  postamble << custom_inspection.prepend(' ')
                end

                "#<#{self.class}:#{'0x%x' % (object_id << 1)}#{postamble}>"
              end

              def pretty_print(q)
                $stderr.puts 'pretty print'
                attributes_to_inspect =
                  if respond_to?(:inspectable_attributes)
                    inspectable_attributes.map { "@#{_1}" }
                  else
                    instance_variables.sort
                  end

                q.object_address_group(self) do
                  q.seplist(attributes_to_inspect, lambda { q.text ',' }) do |ivar|
                    q.breakable
                    ivar = ivar.to_s if Symbol === ivar
                    q.text ivar
                    q.text '='
                    q.group(1) {
                      q.breakable ''
                      q.pp(instance_eval(ivar))
                    }
                  end
                  q.text custom_inspection.prepend(' ') if respond_to?(:custom_inspection)
                end
              end
            end
          end
        end
      end
    end
  end
end
