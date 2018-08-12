# frozen_string_literal: true
# vim: ai ts=2 sts=2 et sw=2 ft=ruby
# rubocop:disable all
<?rb singleton_class
       .__send__(:define_method, :quote) { |input| input.to_s.inspect } ?>

Gem::Specification.new do |s|
  s.name        = #{quote(@name)}
  s.version     = #{quote(@version)}
  s.date        = #{quote(@date)}
  s.summary     = #{quote(@summary)}
  s.description = #{quote(@description)}

  s.licenses    = #{@licenses}
  s.authors     = #{@authors}
  s.email       = #{quote(@email)}
  s.homepage    = #{quote(@homepage)}

  # MUST follow the higher required_ruby_version
  # requires version >= 2.3.0 due to safe navigation operator &
  s.required_ruby_version = ">= 2.3.0"
  s.require_paths = ["lib"]

  s.files = [
    ".yardopts",
    s.require_paths.map { |rp| [rp, "/**/*.rb"].join },
    s.require_paths.map { |rp| [rp, "/**/*.yml"].join },
  ].flatten.map { |m| Dir.glob(m) }.flatten

  #{@dependencies.keep(:runtime).to_s.lstrip}
end

# Local Variables:
# mode: ruby
# End:
