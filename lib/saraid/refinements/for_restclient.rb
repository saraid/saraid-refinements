module Saraid
  module Refinements
    module ForRestClient
      refine RestClient::Resource do
        def uri
          @uri ||= URI.parse(url)
        end

        def with_query(**params)
          [uri.query, params.map { |key, value| "#{key}=#{value}" }]
            .flatten
            .reject(&:nil?)
            .join('&')
            .yield_self { |query| self.class.new(uri.dup.tap { |u| u.query = query }.to_s, options) }
        end
      end

      refine RestClient::Response do
        def error_unless_success(error, message)
          tap { raise error, message unless success? }
        end

        def success?
          (200..299).include?(code)
        end
      end
    end
  end
end

