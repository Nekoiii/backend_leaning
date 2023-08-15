# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # The name can't be the same as logged_in? method in sessions_helper.rb
    # *But can't use the name test_logged_in!!!! Because using the prefix test_ 
    # in a method name typically designates a test case, so using it for a helper 
    # function might cause confusion.
    def is_logged_in?
      !session[:user_id].nil?
    end

    include ApplicationHelper
  end
end
