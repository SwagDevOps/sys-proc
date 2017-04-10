# frozen_string_literal: true

require 'sys/proc/concerns'

# Provides Operating System related methods
#
# This ``Concern`` loads system (OS) related sub-concern (specialisation)
module Sys::Proc::Concerns::System
  extend ActiveSupport::Concern

  # Related concern is included recursively
  included { include system_concern }

  # Identify operating system
  #
  # @return [Symbol]
  def system
    (RbConfig::CONFIG['host_os'] || 'generic').tr('-', '_').to_sym
  end

  # Get operating system related concern
  #
  # @return [Module]
  def system_concern
    r = "sys/proc/concerns/system/#{system}"

    return load_class(r)
  rescue LoadError => e
    raise unless /^cannot load such file -- #{Regexp.quote(r)}/ =~ e.to_s

    return load_class('sys/proc/concerns/system/generic')
  end

  protected

  # @todo use an helper instead
  # @return [Class]
  def load_class(r)
    require 'active_support/inflector'
    require r

    inflector = ActiveSupport::Inflector
    inflector.constantize(inflector.classify(r))
  end
end
