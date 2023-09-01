# frozen_string_literal: true

module Services
  module Builder
    class MissingHeadersError < StandardError
      def initialize
        msg = 'You must provide the headers'
        super(msg)
      end
    end
  end
end
