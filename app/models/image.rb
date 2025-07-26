class Image < ApplicationRecord
  include AttachmentUploader::Attachment(:image)

  belongs_to :uploadable, optional: true, polymorphic: true
end
