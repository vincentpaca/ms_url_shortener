class ShortenedUrl < ApplicationRecord
  validates :original_url, presence: true

  before_create :generate_unique_name

  has_many :visits

  private

  def generate_unique_name
    self.unique_name = SecureRandom.urlsafe_base64(7)
  end
end
