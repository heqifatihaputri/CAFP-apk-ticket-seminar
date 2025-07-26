# frozen_string_literal: true
require "image_processing/mini_magick"

class AttachmentUploader < BaseUploader
  plugin :validation_helpers
  # plugin :remote_url
  plugin :determine_mime_type
  plugin :derivatives

  Attacher.validate do
    validate_mime_type_inclusion %w[image/jpeg image/png image/jpg]
  end

  Attacher.derivatives_processor do |original|
    if file.metadata["mime_type"].include?("image")
      magick = ImageProcessing::MiniMagick.source(original)
      # magick.resize_to_fill!(300, 300)
      {
        large:  magick.resize_to_limit!(1000, 1000),
        medium: magick.resize_to_limit!(500, 500),
        small:  magick.resize_to_limit!(300, 300),
      }
    end
  end

  def generate_location(io, context = {})
    return super if Rails.env.development?
  end

  class Attacher
    def promote(*)
      create_derivatives # creates automatically and preserves usual :versions plugin behaviour

      super
    end
  end
end

