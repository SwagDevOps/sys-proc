# frozen_string_literal: true

require 'sys/proc/concern'
require 'sys/proc/concern/helpers'

# Provides Operating System related methods
#
# This ``Concern`` loads system (OS) related sub-concern (specialisation)
module Sys::Proc::Concern::System
  extend ActiveSupport::Concern
  include Sys::Proc::Concern::Helpers

  # Related concern is included recursively
  included { include system_concern }

  # Identify operating system
  #
  # @return [Symbol]
  def system
    (@system || (RbConfig::CONFIG['host_os'] || 'generic').tr('-', '_')).to_sym
  end

  # Get operating system related concern
  #
  # @return [Module]
  def system_concern
    r = "sys/proc/concern/system/#{system}"

    return load_class(r)
  rescue LoadError => e
    raise unless /^cannot load such file -- #{Regexp.quote(r)}/ =~ e.to_s

    return load_class('sys/proc/concern/system/generic')
  end

  protected

  # Load a class from a require path and return it
  #
  # @return [Class]
  def load_class(r)
    require r

    inflector = helpers.get(:inflector)
    inflector.constantize(inflector.classify(r))
  end
end
