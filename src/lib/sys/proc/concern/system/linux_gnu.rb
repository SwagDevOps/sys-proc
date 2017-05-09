# frozen_string_literal: true

require 'sys/proc/concern/helper'
require 'sys/proc/concern/system'
require 'sys/proc/concern/system/generic'
require 'sys/proc/system/linux_gnu/lib_c'

# Provides specific Linux-GNU methods
module Sys::Proc::Concern::System::LinuxGnu
  extend ActiveSupport::Concern
  include Sys::Proc::Concern::Helper

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

  def libc
    @libc ||= Sys::Proc::System::LinuxGnu::LibC.new
    @libc
  end
end
