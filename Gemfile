# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# gem "rails"

gem 'puma'
gem 'sinatra'
gem 'sqlite3'

group :development, :test do
  # rerun depends on this
  gem 'rb-fsevent'
  gem 'rerun'
  gem 'rubocop', require: false
end
