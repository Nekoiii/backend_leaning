class AwsController < ApplicationController
  def index
    # * for test
    render plain: 'xxx'
    # render plain: Rails.application.credentials.aws[:access_key_id]
  end
end
