require "vcr"

VCR.configure do |config|
  # config.filter_sensitive_data("<SCRUBBED_SOME_API_KEY>") { ENV.fetch("SOME_API_KEY", nil) }
  # Scrubbing these by default just in-case they contain any sensitive data
  config.before_record do |interaction|
    if interaction.request.headers["Cookie"]
      interaction.request.headers["Cookie"] = ["<SCRUBBED>"]
    end
    if interaction.response.headers["Set-Cookie"]
      interaction.response.headers["Set-Cookie"] = ["<SCRUBBED>"]
    end
  end

  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
end
