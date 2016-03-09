# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( main.css )
Rails.application.config.assets.precompile += %w( modernizr-2.8.3-respond-1.4.2.min.js )
Rails.application.config.assets.precompile += %w( material.min.js )
Rails.application.config.assets.precompile += %w( jquery-2.1.4.min.js )
Rails.application.config.assets.precompile += %w( page.js )
Rails.application.config.assets.precompile += %w( toggle-visibility.js )
Rails.application.config.assets.precompile += %w( lightbox.js )
Rails.application.config.assets.precompile += %w( dropzone.js )
Rails.application.config.assets.precompile += %w( context-menu.js )
Rails.application.config.assets.precompile += %w( popup.js )
Rails.application.config.assets.precompile += %w( upload.js )
Rails.application.config.assets.precompile += %w( move_file_modal.js )
Rails.application.config.assets.precompile += %w( application.js )

