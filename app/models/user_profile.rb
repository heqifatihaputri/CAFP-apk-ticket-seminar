class UserProfile < ApplicationRecord
  include AttachmentUploader::Attachment(:avatar)

  belongs_to :user
  belongs_to :country

  enum gender: { man: 0, woman: 1, other: 2 }
  enum marital_status: {"Single": 0, "Married": 1}
end
