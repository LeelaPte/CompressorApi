# frozen_string_literal: true

module Services
  module ZipCompressor
    class MissingFilesError < StandardError
      def initialize(missing_files)
        msg = "The '#{missing_files.join(', ')}' #{'file'.pluralize(missing_files.size)} not found"
        super(msg)
      end
    end
  end
end
