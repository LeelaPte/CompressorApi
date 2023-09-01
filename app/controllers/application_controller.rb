# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Api::Concerns::ErrorsHandling
end
