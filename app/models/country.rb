class Country < ApplicationRecord
  has_many :user_profiles
  has_many :venues
end
