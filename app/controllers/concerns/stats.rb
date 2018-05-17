module Stats
  extend ActiveSupport::Concern

  private

  def record_visitor
    visit = @shortened_url.visits.new(
      user_agent: request.env['HTTP_USER_AGENT'],
      ip_address: request.remote_ip,
      referrer: request.env['HTTP_REFERER']
    )

    visit.save!
  end
end
