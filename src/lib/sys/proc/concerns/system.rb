# frozen_string_literal: true

require 'sys/proc/concerns'

# Provides Operating System related methods
module Sys::Proc::Concerns::System
  extend ActiveSupport::Concern

  # Related concern is included recursively
  included do
    if system_concern
      include system_concern
    else
      raise NotImplementedError, "Not implemented '#{host_os}'"
    end
  end

  def host_os
    (RbConfig::CONFIG['host_os'] || 'generic').tr('-', '_')
  end

  # @return [Module]
  def system_concern
    ["sys/proc/concerns/system/#{host_os}",
     "sys/proc/concerns/system/generic"].each do |r|
      begin
        require r.to_s

        return inflector.constantize(inflector.classify(r))
      rescue LoadError
      rescue NameError
      end
    end
  end

  protected

  def inflector
    require 'active_support/inflector'

    ActiveSupport::Inflector
  end
end
