# frozen_string_literal: true

module Services
  module Builder
    class MissingArgsError < StandardError
      def initialize
        msg = 'You must provide values with the proper structure'
        super(msg)
      end
    end
  end
end
