require "shrine"
require "shrine/storage/file_system"
# require "shrine/storage/s3"
require "mimemagic"

cache_shrine = Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache") # temporary
store_shrine = Shrine::Storage::FileSystem.new("public", prefix: "uploads") # permanent

Shrine.storages = {
  cache: cache_shrine,
  store: store_shrine
}

Shrine.plugin :url_options,    cache: { public: true }, store: { public: true }
Shrine.plugin :remote_url,     max_size: 200*1024*1024
Shrine.plugin :data_uri

Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :derivatives
Shrine.plugin :determine_mime_type
Shrine.plugin :upload_endpoint

Date::DATE_FORMATS[:default]="%d.%m.%Y"
Time::DATE_FORMATS[:default]="%d.%m.%Y %H:%M"