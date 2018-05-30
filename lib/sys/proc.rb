# frozen_string_literal: true

# Copyright (C) 2017 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require 'English'

# The Sys module is only used as a namespace
module Sys
  # rubocop:disable Style/Documentation

  class Proc
    require_relative 'proc/version'

    VERSION = Version.new.freeze
  end

  # rubocop:enable Style/Documentation
end

# Operations on current process
#
# @see http://man7.org/linux/man-pages/man2/prctl.2.html
# @see http://www.tldp.org/LDP/Linux-Filesystem-Hierarchy/html/proc.html
class Sys::Proc
  require 'singleton'
  %i{system static_instance}.each do |req|
    require "sys/proc/concern/#{req}"
  end

  include Concern::StaticInstance
  include Concern::System

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

  # Time in seconds since system boot
  #
  # @see https://blog.dnsimple.com/2018/03/elapsed-time-with-ruby-the-right-way/
  # @return [Float]
  def uptime
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end
end
