source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem 'rails', '~> 7.0.2', '>= 7.0.2.3'
gem 'puma'
gem 'importmap-rails'
gem 'jbuilder'
gem 'bootsnap', require: false
gem 'mongoid'
gem 'redis-rails'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end
