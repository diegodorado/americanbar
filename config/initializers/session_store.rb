# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ab2_session',
  :secret      => '27b434a2a373042d9dc5a35748550c3f4cbd5d76cd8ca8199e3b71297de853135172587d4ced96dac1fc819b0c73f4ef6366d30022e86bfeb274f64accc00778'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
