# frozen_string_literal: true

require 'sys/proc/concern/helper'
require 'sys/proc/concern/system'
require 'sys/proc/concern/system/generic'
require 'sys/proc/system/freebsd/lib_c'

# Provides specific Freebsd methods
module Sys::Proc::Concern::System::Freebsd
  extend ActiveSupport::Concern

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
