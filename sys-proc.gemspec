# frozen_string_literal: true
# vim: ai ts=2 sts=2 et sw=2 ft=ruby
# rubocop:disable all

# MUST follow the higher required_ruby_version
# gem with higher required_ruby_version was activesupport
# but requires version >= 2.3.0 due to safe navigation operator &

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

  s.add_runtime_dependency("dry-inflector", ["~> 0.1"])
  s.add_runtime_dependency("version_info", ["~> 1.9"])
end

# Local Variables:
# mode: ruby
# End:
