require 'test_helper'

class ShortenedUrlTest < ActiveSupport::TestCase

  def setup
    @url = ShortenedUrl.new(original_url: 'https://bla.bla')
  end

  test 'valid url' do
    assert @url.valid?
  end

  test 'invalid url' do
    @url.original_url = 'invalid url'
    refute @url.valid?
  end

  test 'should add a unique name on create' do
    @url.save
    assert_not_empty @url.unique_name
  end
end
