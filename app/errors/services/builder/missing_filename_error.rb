# frozen_string_literal: true

module Services
  module Builder
    class MissingFilenameError < StandardError
      def initialize
        msg = 'You must provide the filename'
        super(msg)
      end
    end
  end
end
