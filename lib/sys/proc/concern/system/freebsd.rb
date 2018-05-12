# frozen_string_literal: true

# Copyright (C) 2017 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require 'sys/proc/concern/helper'
require 'sys/proc/concern/system'
require 'sys/proc/concern/system/generic'
require 'sys/proc/system/freebsd/lib_c'

# Provides specific Freebsd methods
module Sys::Proc::Concern::System::Freebsd
  include Sys::Proc::Concern::Helper
  include Sys::Proc::System::Freebsd

  # Set program name
  #
  # @param [String] progname
  # @return [String]
  def progname=(progname)
    self.helper.get('system/generic').setprogname(progname) do |s|
      libc.setprogname(s.progname)

      self.progname
    end
  end

  # Get program name
  #
  # @return [String]
  def progname
    libc.getprogname
  end

  protected

  # @return [Sys::Proc::System::Freebsd::LibC]
  def libc
    @libc ||= LibC.new
    @libc
  end
end
