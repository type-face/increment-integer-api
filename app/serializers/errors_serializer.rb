# frozen_string_literal: true

module ErrorsSerializer
  def self.serialize(object)
    object.errors.messages.map do |field, errors|
      errors.map do |error_message|
        {
          status: 422,
          detail: "#{field}: #{error_message}"
        }
      end
    end.flatten
  end
end
