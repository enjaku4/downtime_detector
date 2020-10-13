FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "foobar#{n}" }
    # this user's password is 'password'
    password_salt { '$2a$12$FwCFfyh3PZMzot5mzgQ5bu' }
    password_hash { '$2a$12$FwCFfyh3PZMzot5mzgQ5buhcVyggyKXh32NbwbJoI2MRIuho3BQ9S' }
  end
end
