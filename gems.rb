# frozen_string_literal: true

# bundle install --path vendor/bundle
source 'https://rubygems.org'

gem 'dry-inflector', '~> 0.1', '< 0.2'
gem 'version_info', '~> 1.9'

group :development do
  gem 'rake', '~> 12.0'
  gem 'pry', '~> 0.10'
  gem 'dotenv', '~> 2.2'
  gem 'cliver', '= 0.3.2'
  gem 'rubocop', '~> 0.49'
  gem 'gemspec_deps_gen', '= 1.1.2'
  gem 'tenjin', '~> 0.7'
  gem 'rainbow', '~> 2.2'
  gem 'tty-editor', '~> 0.2'
end

group :doc, :development do
  gem 'yard', '~> 0.9'
  # Github Flavored Markdown in YARD
  gem 'redcarpet', '~> 3.4'
  gem 'github-markup', '~> 1.6'
end

group :test, :development do
  gem 'rspec', '~> 3.6'
end
