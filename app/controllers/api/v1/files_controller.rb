# frozen_string_literal: true

module Api
  module V1
    class FilesController < ApplicationController
      def generate
        zip_data = FileManagerService.call

        send_data(zip_data[:binary_data],
                  type: 'application/zip',
                  filename: zip_data[:filename])
      end
    end
  end
end
