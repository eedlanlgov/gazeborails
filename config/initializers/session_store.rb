# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gazebo_session',
  :secret      => '7a327331fbe552e02d7d23883565847a13b522a24bf5fae23a11aa5c8e0a9c4f1c51b49c50d77d306060ccf1f6a5c2d4d7bb26c96c5f6a152043aa47915ed83a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
