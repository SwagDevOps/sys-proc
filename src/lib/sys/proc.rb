# frozen_string_literal: true

require 'English'

# The Sys module is only used as a namespace
module Sys
end

# Operations on current process
#
# @see http://man7.org/linux/man-pages/man2/prctl.2.html
# @see http://www.tldp.org/LDP/Linux-Filesystem-Hierarchy/html/proc.html
class Sys::Proc
  require 'singleton'
  %i{versionable system static_instance}.each do |req|
    require "sys/proc/concerns/#{req}"
  end

  VERSION_PATH_LEVELS = 3
  include Concerns::Versionable
  include Concerns::StaticInstance
  include Concerns::System

  # @param [String|Symbol] system
  def initialize(system = nil)
    @system = system
  end

  class << self
    # Get available methods
    #
    # @return [Array<Symbol>]
    def methods
      super() + new.methods
    end

    # Get available public methods
    #
    # @return [Array<Symbol>]
    def public_methods
      super() + new.public_methods
    end
  end

  def pid
    $PROCESS_ID
  end
end
