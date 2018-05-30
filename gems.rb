# frozen_string_literal: true

# bundle install --path vendor/bundle
source 'https://rubygems.org'

group :default do
  gem 'dry-inflector', '~> 0.1'
end

group :development do
  gem 'kamaze-project', '~> 1.0'
  gem 'listen', '~> 3.1'
  gem 'pry', '~> 0.11'
  gem 'pry-coolline', '~> 0.2'
end

group :doc, :development do
  # Github Flavored Markdown in YARD
  gem 'github-markup', '~> 2.0'
  gem 'redcarpet', '~> 3.4'
end

group :test, :development do
  gem 'rspec', '~> 3.7'
end
