# frozen_string_literal: true

module Services
  module Builder
    class MissingRowsError < StandardError
      def initialize
        msg = 'You must provide the rows'
        super(msg)
      end
    end
  end
end
