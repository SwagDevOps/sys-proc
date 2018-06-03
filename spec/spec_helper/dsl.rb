# frozen_string_literal: true

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
