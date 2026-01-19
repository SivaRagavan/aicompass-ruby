class Assessment < ApplicationRecord
  belongs_to :user

  validates :company_name, presence: true
  validates :invite_token, presence: true, uniqueness: true
  validates :invite_expires_at, presence: true
  validates :status, presence: true

  scope :recent_first, -> { order(created_at: :desc) }

  def expired?
    invite_expires_at < Time.current
  end

  def active?
    status == "active" && !expired?
  end

  def progress_percent
    progress_data&.fetch("percent", 0) || 0
  end
end
