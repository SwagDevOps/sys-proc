# frozen_string_literal: true
# vim: ai ts=2 sts=2 et sw=2 ft=ruby
# rubocop:disable all

Gem::Specification.new do |s|
  s.name        = "sys-proc"
  s.version     = "1.1.2"
  s.date        = "2018-06-01"
  s.summary     = "Cross-platform interface to customize process name"
  s.description = "A cross-platform interface to customize process name"

  s.licenses    = ["GPL-3.0"]
  s.authors     = ["Dimitri Arrigoni"]
  s.email       = "dimitri@arrigoni.me"
  s.homepage    = "https://github.com/SwagDevOps/sys-proc"

  # MUST follow the higher required_ruby_version
  # requires version >= 2.3.0 due to safe navigation operator &
  s.required_ruby_version = ">= 2.3.0"
  s.require_paths = ["lib"]

  s.files = [
    ".yardopts",
    s.require_paths.map { |rp| [rp, "/**/*.rb"].join },
    s.require_paths.map { |rp| [rp, "/**/*.yml"].join },
  ].flatten.map { |m| Dir.glob(m) }.flatten

  s.add_runtime_dependency("dry-inflector", ["~> 0.1"])
end

# Local Variables:
# mode: ruby
# End:
