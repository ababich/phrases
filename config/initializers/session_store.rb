# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_phrases_session',
  :secret      => 'a941f98233b423f2386345b66e3fd1cdafa700867b0925a2b74aed08f0c471834558b1e9419ff3ec5f6844172361bc61c244397986afd79bc7b05dd5c8cdc6f4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
