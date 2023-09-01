# frozen_string_literal: true

module Api
  module Concerns
    module ErrorsHandling
      extend ActiveSupport::Concern

      included do
        rescue_from StandardError, with: :standard_error
        rescue_from ActionController::ParameterMissing, with: :missing_parameter
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
        rescue_from Services::ZipCompressor::MissingArgsError, with: :standard_error
        rescue_from Services::ZipCompressor::MissingFilesError, with: :record_not_found
        rescue_from Services::Builder::MissingArgsError, with: :record_not_found
        rescue_from Services::Builder::MissingFilenameError, with: :standard_error
        rescue_from Services::Builder::MissingHeadersError, with: :standard_error
        rescue_from Services::Builder::MissingRowsError, with: :standard_error
      end

      private

      def standard_error(exception)
        render json: { error: exception.message }, status: :bad_request
      end

      def missing_parameter(exception)
        render json: { error: exception.exception.message }, status: :bad_request
      end

      def record_not_found(exception)
        render json: { error: exception.exception.message }, status: :not_found
      end
    end
  end
end
