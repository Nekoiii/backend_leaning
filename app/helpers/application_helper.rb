# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = nil)
    base_title = APP_NAME
    [page_title, base_title].compact.join(' | ')
  end
end
