# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require 'fiddle'
require_relative '../helper'

# System helper
class Sys::Proc::Helper::LibC
  def initialize
    @loadeds = {}
  end

  # ``libc`` shared objects identified by system
  #
  # @return [Hash]
  def loadables
    {
      linux_gnu: 'libc.so.6',
      freebsd: 'libc.so.7',
    }
  end

  # Open shared object (by system)
  #
  # @param [Symbol] system
  # @return [self]
  def dlopen(system = nil)
    system = (system.nil? ? Sys::Proc.system : system).to_sym

    loadeds[system] ||= Fiddle.dlopen(loadables.fetch(system))

    loadeds[system]
  end

  # Denote if ``libc`` is seen as availbale on targeted system
  #
  # @return [Boolean]
  def available?(system = nil)
    begin
      dlopen(system)
    rescue Fiddle::DLError
      return false
    rescue KeyError
      return false
    end

    loadables[system] != nil
  end

  protected

  # Cache for loaded shared objects
  attr_reader :loadeds
end
