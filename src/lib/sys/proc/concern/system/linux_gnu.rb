# frozen_string_literal: true

require 'sys/proc/concern/helper'
require 'sys/proc/concern/system'
require 'sys/proc/concern/system/generic'

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
      prctl.set_name(s.progname)

      self.progname
    end
  end

  # Get program name
  #
  # @return [String]
  def progname
    prctl.get_name
  end

  protected

  # @return [Sys::Proc::System::LinuxGnu::Prctl]
  def prctl
    require 'sys/proc/system/linux_gnu/prctl'

    return Sys::Proc::System::LinuxGnu::Prctl.new
  end
end
