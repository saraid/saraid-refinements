module Saraid
  module Refinements
    module ForClass
      module Inspection
        refine Class do
          def saneify_inspection!
            class_eval do
              def inspect
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
            end
          end
        end
      end
    end
  end
end
