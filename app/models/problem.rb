# == Schema Information
#
# Table name: problems
#
#  id             :bigint           not null, primary key
#  description    :text
#  name           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  web_address_id :bigint           not null
#
# Indexes
#
#  index_problems_on_web_address_id  (web_address_id)
#
# Foreign Keys
#
#  fk_rails_...  (web_address_id => web_addresses.id)
#
class Problem < ApplicationRecord
  belongs_to :web_address
end
