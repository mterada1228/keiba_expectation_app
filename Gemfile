source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'

# Use the database for Active Record
gem 'mysql2', '~> 0.5.3', group: [:development, :test]
gem 'pg', '~> 1.2.3', group: :production

# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2', '>= 5.2.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 11.1.3', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.6.0'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.14'
  gem 'pry-rails', '~> 0.3.9'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '~> 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.1.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec', '~> 1.0.4'
  # Rubocop
  gem 'rubocop', '~> 0.87'
  gem 'rubocop-performance', '~> 1.8'
  gem 'rubocop-rails', '~> 2.8'
  gem 'rubocop-rspec', '~> 1.44'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.15'
  gem 'selenium-webdriver', '~> 3.142.7'
  gem 'launchy', '~> 2.4.3'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', '~> 4.4.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 1.2.7', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# DBのデータをseedsに変換
gem 'seed_dump', '~> 3.3.1'

# グラフツール
gem "chartkick", '~> 3.4.0'

# eunumの値をviewで日本語化する
gem 'enum_help', '~> 0.0.17'
