require 'test_helper'

class GettingStatsTest < ActionDispatch::IntegrationTest

  def setup
    @shortened_url = shortened_urls(:bla_url)
    @first_visitor = visits(:first_visitor)
    @second_visitor = visits(:second_visitor)
  end

  test "when the URL doesn't exist" do
    put stats_path(url: 'https://nonexistent.url')

    assert_response :missing
  end

  test 'checking the stats' do
    put stats_path(url: "https://example.com/#{@shortened_url.unique_name}")

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal json_response['click_stats']['summary']['total_clicks'], 2
    assert_not_empty json_response['click_stats']['visits']
  end
end
