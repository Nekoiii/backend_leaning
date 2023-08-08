# frozen_string_literal: true

module Types
  class ImageType < Types::BaseObject
    field :url, String, null: false

    def url
      Rails.application.routes.url_helpers.rails_blob_url(object, only_path: true)
    end
  end
end
