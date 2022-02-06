# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add vendor paths
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets')

# Precompile core stylesheets
Rails.application.config.assets.precompile += [
  "stylesheets/bootstrap.css",
  "stylesheets/appwork.css",
  "stylesheets/theme-corporate.css",
  "stylesheets/colors.css",
  "stylesheets/uikit.css"
]

# Precompile core javascripts
Rails.application.config.assets.precompile += ['javascripts/*.js']
Rails.application.config.assets.precompile += %w( list.js/dist/list.js )


# Precompile fonts
Rails.application.config.assets.precompile += ['fonts/*']

# Precompile libs
lib_files = Dir[Rails.root.join('vendor', 'assets', 'libs', '**', '[^_]*.*')]
lib_files.map! { |file| file.sub(%r(#{Rails.root.join('vendor', 'assets/')}), '') }
lib_files.map! { |file| file.sub(%r(\.(scss)), '.css') }
Rails.application.config.assets.precompile += lib_files

# Precompile pages
Rails.application.config.assets.precompile += ['stylesheets/pages/*.css']

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile += %w( chartjs-plugin-datalabels/dist/chartjs-plugin-datalabels.js )
Rails.application.config.assets.precompile += %w( node-vibrant/dist/vibrant.js )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

Rails.application.config.assets.precompile += %w( application-mailer.scss )
Rails.application.config.assets.precompile += %w( pdf/pdf.scss )
Rails.application.config.assets.precompile += %w( pdf/pdf_production.scss )
