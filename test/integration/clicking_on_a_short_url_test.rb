require 'test_helper'

class ClickingOnAShortUrlTest < ActionDispatch::IntegrationTest

  def setup
    @shortened_url = shortened_urls(:bla_url)
  end

  test 'following a short link' do
    get "https://example.com/#{@shortened_url.unique_name}"

    visitor = Visit.last

    assert_redirected_to @shortened_url.original_url
    assert_not_nil visitor
  end
end
