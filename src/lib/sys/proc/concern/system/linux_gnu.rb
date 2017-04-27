# frozen_string_literal: true

require 'sys/proc/concern/helper'
require 'sys/proc/concern/system'
require 'sys/proc/concern/system/generic'

# Provides specific Linux-GNU methods
module Sys::Proc::Concern::System::LinuxGnu
  extend ActiveSupport::Concern
  include Sys::Proc::Concern::Helper

  # Set process title
  #
  # @param [String] title
  # @return [String]
  def title=(title)
    self.helper.get('system/generic').setproctitle(title) do |s|
      prctl.set_name(s.title)

      self.title
    end
  end

  # Get process title
  #
  # @return [String]
  def title
    prctl.get_name
  end

  protected

  # @return [Sys::Proc::Os::LinuxGnu::Prctl]
  def prctl
    require 'sys/proc/system/linux_gnu/prctl'

    Sys::Proc::System::LinuxGnu::Prctl.new
  end
end
