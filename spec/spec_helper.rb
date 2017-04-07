# Sample of use:
#
# ~~~~
# it { expect(described_class).to define_constant(constant) }
# ~~~~
RSpec::Matchers.define :define_constant do |const|
  match do |owner|
    owner.const_defined?(const)
  end
end
