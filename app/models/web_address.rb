# == Schema Information
#
# Table name: web_addresses
#
#  id                :bigint           not null, primary key
#  http_status_code  :integer
#  notification_sent :boolean          default(FALSE), not null
#  pinged_at         :datetime
#  status            :integer          not null
#  url               :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
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

  def set_ping_result!(http_status_code)
    self.http_status_code = http_status_code
    update_status!
  end

  def mark_as_faulty!
    self.http_status_code = nil
    update_status!(:error)
  end

  private

    def update_status!(status = nil)
      self.status = status || resolve_status
      update!(pinged_at: DateTime.current)
      post_set_status
    end

    def resolve_status
      http_status_code.in?(200...400) ? :up : :down
    end

    def post_set_status
      update!(notification_sent: false) if up?

      if eligible_for_sending_notification?
        WebAddresses::UsersNotificationJob.perform_later(id)
        update!(notification_sent: true)
      end
    end

    def eligible_for_sending_notification?
      (down? || error?) && !notification_sent?
    end
end
