# frozen_string_literal: true

require 'rspec/sleeping_king_studios/matchers/core/all'
require '%s/../src/lib/%s' % [__dir__, ENV.fetch('PROJECT_NAME')]

# DSL is a module that provides #host_os, etc.
#
# Use:
#
# ```
# self.extend RSpec::DSL
# ```
module RSpec::DSL
  # Get current platform (os) identifier
  #
  # @return [String]
  def host_os
    RbConfig::CONFIG['host_os']
  end
end

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
