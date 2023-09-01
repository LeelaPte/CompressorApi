# frozen_string_literal: true

module Services
  module ZipCompressor
    class MissingArgsError < StandardError
      def initialize
        msg = 'You must provide values'
        super(msg)
      end
    end
  end
end
