require 'test_helper'

class CreatingAShortUrlTest < ActionDispatch::IntegrationTest
  test 'can see the form by default' do
    get '/'
    assert_response :success
    assert_select 'h1', 'URL Shortener'
    assert_select '#shortened_url_original_url'
  end

  test 'it creates a shortened name on Shorten!' do
    get '/'

    post '/shortened_urls',
      params: { shortened_url: { original_url: 'https://bla.bla' } }

    shortened_url = ShortenedUrl.last

    assert_not_nil shortened_url.unique_name
    assert_redirected_to shortened_url_path(shortened_url)
    follow_redirect!
    assert_response :success
    assert_select 'h1', 'Your shortened URL:'
    assert_select '#shortened-url', "#{request.base_url}/#{shortened_url.unique_name}"
  end
end
