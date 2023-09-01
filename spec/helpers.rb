# frozen_string_literal: true

module Helpers
  def json
    JSON.parse(response.body)
  end

  def json_with_indifferent_access
    json.with_indifferent_access
  end

  def json_map_with_indifferent_access
    json.map(&:with_indifferent_access)
  end
end
