# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.scss, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( application.scss )
Rails.application.config.assets.precompile += %w( home.css )
Rails.application.config.assets.precompile += %w( loading.css )
Rails.application.config.assets.precompile += %w( application.js )
Rails.application.config.assets.precompile += %w( manual_sync.js )
Rails.application.config.assets.precompile += %w( home.coffee )


Rails.application.config.assets.precompile += %w( app.png )
Rails.application.config.assets.precompile += %w( app.png )
Rails.application.config.assets.precompile += %w( app-screen.png )
Rails.application.config.assets.precompile += %w( featured-app.png )
Rails.application.config.assets.precompile += %w( footer-logo.png )
Rails.application.config.assets.precompile += %w( logo.png )
Rails.application.config.assets.precompile += %w( mockup.png )
Rails.application.config.assets.precompile += %w( skyLogo.png )