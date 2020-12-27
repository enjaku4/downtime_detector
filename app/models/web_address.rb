# == Schema Information
#
# Table name: web_addresses
#
#  id                 :bigint           not null, primary key
#  http_status_code   :integer
#  notifications_sent :boolean          default(FALSE), not null
#  pinged_at          :datetime
#  status             :integer          default("unknown"), not null
#  url                :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_web_addresses_on_url  (url) UNIQUE
#
class WebAddress < ApplicationRecord
  enum status: { unknown: 0, up: 1, down: 2, error: 3 }

  has_and_belongs_to_many :users
  has_many :problems, dependent: :destroy

  scope :ready_to_ping, -> { where('pinged_at IS NULL or pinged_at < ?', 5.minutes.ago) }

  def faulty?
    down? || error?
  end

  def update_ping_time!
    update!(pinged_at: DateTime.current)
  end

  def reset_notifications!
    update!(notifications_sent: false)
  end

  def delete_old_problems!
    problems.where.not(id: problems.latest).destroy_all
  end
end
