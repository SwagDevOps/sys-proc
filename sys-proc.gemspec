# frozen_string_literal: true
# vim: ai ts=2 sts=2 et sw=2 ft=ruby
#
# Should follow the higher required_ruby_version
# at the moment, gem with higher required_ruby_version is activesupport
# https://github.com/rails/rails/blob/master/activesupport/

Gem::Specification.new do |s|
  s.name        = 'sys-proc'
  s.version     = '0.0.1'
  s.date        = '2017-03-29'
  s.summary     = 'An interface providing cross-platform process operations'
  s.description = 'An interface providing cross-platform process operations'

  s.licenses    = ["GPL-3.0"]
  s.authors     = ["Dimitri Arrigoni"]
  s.email       = 'dimitri@arrigoni.me'
  s.homepage    = 'https://github.com/SwagDevOps/ruby-sys-proc'

  s.required_ruby_version = '>= 2.2.2'
  s.require_paths = ['src/lib']
  s.files         = Dir.glob('src/**/**.rb') + \
                    Dir.glob('src/**/version_info.yml')

  s.add_runtime_dependency "activesupport", ["~> 5.0"]
  s.add_runtime_dependency "version_info", ["~> 1.9"]
  s.add_development_dependency "rake", ["~> 11.3"]
  s.add_development_dependency "pry", ["~> 0.10"]
  s.add_development_dependency "dotenv", ["~> 2.2"]
  s.add_development_dependency "cliver", ["= 0.3.2"]
  s.add_development_dependency "rubocop", ["~> 0.47"]
  s.add_development_dependency "gemspec_deps_gen", ["= 1.1.2"]
  s.add_development_dependency "tenjin", ["~> 0.7"]
  s.add_development_dependency "rainbow", ["~> 2.2"]
  s.add_development_dependency "tty-editor", ["~> 0.2"]
  s.add_development_dependency "yard", ["~> 0.9"]
  s.add_development_dependency "redcarpet", ["~> 3.4"]
  s.add_development_dependency "github-markup", ["~> 1.4"]
  s.add_development_dependency "rspec", ["~> 3.4"]
  s.add_development_dependency "rspec-sleeping_king_studios", ["~> 2.1"]
end

# Local Variables:
# mode: ruby
# End:
