# == Schema Information
#
# Table name: web_addresses
#
#  id               :bigint           not null, primary key
#  http_status_code :integer
#  pinged_at        :datetime
#  status           :integer          not null
#  url              :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_web_addresses_on_url  (url) UNIQUE
#
class WebAddress < ApplicationRecord
  enum status: { unknown: 0, up: 1, down: 2, error: 3 }

  has_and_belongs_to_many :users

  scope :ready_to_ping, -> { where('pinged_at IS NULL or pinged_at < ?', 5.minutes.ago) }

  def set_ping_result!(http_status_code)
    self.http_status_code = http_status_code
    self.status = resolve_status
    update!(pinged_at: DateTime.current)
  end

  def mark_as_faulty!
    self.status = :error
    update!(pinged_at: DateTime.current)
  end

  private

    def resolve_status
      http_status_code.in?(200...400) ? :up : :down
    end
end
