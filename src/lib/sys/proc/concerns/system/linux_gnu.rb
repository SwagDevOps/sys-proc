# frozen_string_literal: true

require 'sys/proc/concerns/system'

# Provides specific Linux-GNU methods
module Sys::Proc::Concerns::System::LinuxGnu
  extend ActiveSupport::Concern

  # Set process title
  #
  # @param [String] title
  # @return [String]
  def title=(title)
    title = title.to_s

    prctl.set_name(title)
    $PROGRAM_NAME = title

    title
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
