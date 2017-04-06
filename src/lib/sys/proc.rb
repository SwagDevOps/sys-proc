# frozen_string_literal: true

require 'pp'

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

  include ::Singleton
  include Concerns::Versionable
  include Concerns::StaticInstance
  include Concerns::System

  class << self
    # Get available methods
    #
    # @return [Array<Symbol>]
    def methods
      super() + instance.methods
    end

    # Get available public methods
    #
    # @return [Array<Symbol>]
    def public_methods
      super() + instance.public_methods
    end
  end

  def pid
    $PROCESS_ID
  end

  # Sets process title
  #
  def name=(name)
    set_name(name) if methods.include? :set_name

    name
  end

  def name
    #
  end
end
