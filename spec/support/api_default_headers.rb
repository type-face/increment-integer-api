# frozen_string_literal: true

require 'active_support/concern'

module ApiDefaultHeaders
  extend ActiveSupport::Concern

  HTTP_METHODS = %w[get post put delete patch].freeze

  included do
    # make requests jsonapi compliant
    let(:default_headers) do
      {
        HTTP_ACCEPT: 'application/vnd.api+json',
        CONTENT_TYPE: 'application/vnd.api+json'
      }
    end

    HTTP_METHODS.each do |m|
      define_method(m) do |path, *args|
        args[0] ||= {}
        args[0][:headers] ||= {}
        args[0][:headers].merge!(default_headers)
        args[0][:params] ||= {}
        args[0][:params].to_json unless args[0][:params].is_a? String
        super(path, *args)
      end
    end
  end
end
