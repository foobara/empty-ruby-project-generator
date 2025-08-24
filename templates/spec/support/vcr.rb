require "vcr"

VCR.configure do |config|
  # config.filter_sensitive_data("<SCRUBBED_SOME_API_KEY>") { ENV.fetch("SOME_API_KEY", nil) }
  config.before_record do |interaction|
    # Stripping these out just in-case they contain some kind of auth token
    interaction.response.headers.delete("Set-Cookie")
  end

  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
end
