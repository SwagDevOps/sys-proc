# frozen_string_literal: true
# vim: ai ts=2 sts=2 et sw=2 ft=ruby
#
# Should follow the higher required_ruby_version
# at the moment, gem with higher required_ruby_version is activesupport
# https://github.com/rails/rails/blob/master/activesupport/

Gem::Specification.new do |s|
  s.name        = 'sys-proc'
  s.version     = '1.0.5'
  s.date        = '2018-05-12'
  s.summary     = 'A cross-platform interface to customize the process name'
  s.description = 'A cross-platform interface to customize the process name'

  s.licenses    = ["GPL-3.0"]
  s.authors     = ["Dimitri Arrigoni"]
  s.email       = 'dimitri@arrigoni.me'
  s.homepage    = 'https://github.com/SwagDevOps/sys-proc'

  s.required_ruby_version = '>= 2.2.2'
  s.require_paths = ['lib']
  s.files         = ['.yardopts',
                     'lib/**/*.rb',
                     'lib/**/version_info.yml'
                    ].map { |pt| Dir.glob(pt) }.flatten

  s.add_runtime_dependency "dry-inflector", ["< 0.2", "~> 0.1"]
  s.add_runtime_dependency "version_info", ["~> 1.9"]
  s.add_development_dependency "rake", ["~> 12.0"]
  s.add_development_dependency "pry", ["~> 0.10"]
  s.add_development_dependency "dotenv", ["~> 2.2"]
  s.add_development_dependency "cliver", ["= 0.3.2"]
  s.add_development_dependency "rubocop", ["~> 0.49"]
  s.add_development_dependency "gemspec_deps_gen", ["= 1.1.2"]
  s.add_development_dependency "tenjin", ["~> 0.7"]
  s.add_development_dependency "rainbow", ["~> 2.2"]
  s.add_development_dependency "tty-editor", ["~> 0.2"]
  s.add_development_dependency "yard", ["~> 0.9"]
  s.add_development_dependency "redcarpet", ["~> 3.4"]
  s.add_development_dependency "github-markup", ["~> 1.6"]
  s.add_development_dependency "rspec", ["~> 3.6"]
end

# Local Variables:
# mode: ruby
# End:
