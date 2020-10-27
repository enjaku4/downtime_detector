# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  email         :string
#  nickname      :string           not null
#  password_hash :string           not null
#  password_salt :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_users_on_nickname  (nickname) UNIQUE
#
class User < ApplicationRecord
  has_and_belongs_to_many :web_addresses
end
