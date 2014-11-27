module Helpers
  module Requests
    module JsonHelpers
      def json
        @json ||= JSON.parse(response.body, symbolize_names: true)
      end

      def check_attributes_for_item_info(item)
        expect(item).to have_key(:label)
        expect(item).to have_key(:revision)
        expect(item).to have_key(:created_at)
        expect(item).to have_key(:type)
        expect(item).to have_key(:identifier)
      end
    end
  end
end