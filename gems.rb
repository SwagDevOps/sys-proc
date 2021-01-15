# frozen_string_literal: true

# bundle install --path vendor/bundle
source 'https://rubygems.org'

group :default do
  gem 'dry-inflector', '~> 0.1'
end

group :development do
  gem 'kamaze-project', '~> 1.0', '>= 1.0.3'
  gem 'listen', '~> 3.4'
  gem 'rubocop', '~> 0.56'
end

group :development, :repl do
  gem 'interesting_methods', '~> 0.1'
  gem 'pry', '~> 0.11'
  gem 'pry-coolline', '~> 0.2'
end

group :development, :doc do
  gem 'yard', '~> 0.9'
end

group :development, :doc, :markdown do
  gem 'github-markup', '~> 2.0'
  gem 'redcarpet', '~> 3.4'
end

group :development, :test do
  gem 'rspec', '~> 3.7'
  gem 'sham', '~> 2.0'
end
