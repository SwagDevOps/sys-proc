# frozen_string_literal: true

require 'pp'

# The Sys module serves as a namespace only
module Sys
end

# Operations on current process
#
# @see http://man7.org/linux/man-pages/man2/prctl.2.html
# @see http://www.tldp.org/LDP/Linux-Filesystem-Hierarchy/html/proc.html
class Sys::Proc
  require 'singleton'
  require 'sys/proc/concerns/versionable'

  VERSION_PATH_LEVELS = 3
  include ::Singleton
  include Concerns::Versionable

  def pid
    $$
  end

  def host_os
    (RbConfig::CONFIG['host_os'] || 'unknown').gsub(/-gnu$/, '')
  end

  class << self
    # Provides access to instance methods
    def method_missing(method, *args, &block)
      if respond_to_missing?(method)
        instance.public_send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      result = instance.respond_to?(method)
      unless result
        return super if include_private
      end

      result
    end
  end
end
