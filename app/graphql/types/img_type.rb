module Types
  class ImgType < Types::BaseObject
    field :url, String, null: false

    def url
      Rails.application.routes.url_helpers.rails_blob_url(object, only_path: true)
    end
  end
end
