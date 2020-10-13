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
end
