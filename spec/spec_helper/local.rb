# frozen_string_literal: true

require_relative 'factory_struct'

# Local (helper) methods
module Local
  protected

  # Retrieve ``sham`` by given ``name``
  #
  # @param [Symbol] name
  def sham!(name)
    FactoryStruct.sham!(name)
  end

  # Get current platform (os) identifier
  #
  # @return [String]
  def host_os
    RbConfig::CONFIG['host_os']
  end

  # @param [Array<Regexps>] regexps
  # @return [Boolean]
  def host_match?(regexps)
    regexps = [regexps] if regexps.is_a?(Regexp)

    host_os =~ Regexp.union(regexps)
  end
end
