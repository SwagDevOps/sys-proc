# frozen_string_literal: true
# vim: ai ts=2 sts=2 et sw=2 ft=ruby
# rubocop:disable all

# MUST follow the higher required_ruby_version
# gem with higher required_ruby_version was activesupport
# but requires version >= 2.3.0 due to safe navigation operator &

Gem::Specification.new do |s|
  s.name        = '#{@name}'
  s.version     = '#{@version}'
  s.date        = '#{@date}'
  s.summary     = '#{@summary}'
  s.description = '#{@description}'

  s.licenses    = #{@licenses}
  s.authors     = #{@authors}
  s.email       = '#{@email}'
  s.homepage    = '#{@homepage}'

  s.required_ruby_version = '>= 2.2.2'
  s.require_paths = ['lib']
  s.files         = ['.yardopts',
                     'lib/**/*.rb',
                     'lib/**/version_info.yml'
                    ].map { |pt| Dir.glob(pt) }.flatten

  #{@dependencies.keep(:runtime).to_s.lstrip}
end

# Local Variables:
# mode: ruby
# End:
