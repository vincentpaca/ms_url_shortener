class ShortenedUrl < ApplicationRecord
  validates :original_url, presence: true

  before_create :generate_unique_name

  private

  def generate_unique_name
    self.unique_name = SecureRandom.urlsafe_base64(7)
  end
end
