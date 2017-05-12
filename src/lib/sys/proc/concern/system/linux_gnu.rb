# frozen_string_literal: true

require 'sys/proc/concern/helper'
require 'sys/proc/concern/system'
require 'sys/proc/concern/system/generic'
require 'sys/proc/system/linux_gnu/prctl'

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
      prctl.setprogname(s.progname)

      self.progname
    end
  end

  # Get program name
  #
  # @return [String]
  def progname
    prctl.getprogname
  end

  protected

  def prctl
    @prctl ||= Sys::Proc::System::LinuxGnu::Prctl.new
    @prctl
  end
end
