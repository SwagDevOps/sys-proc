# frozen_string_literal: true

require 'sys/proc/concerns/helpers'
require 'sys/proc/concerns/system'
require 'sys/proc/concerns/system/generic'

# Provides specific Linux-GNU methods
module Sys::Proc::Concerns::System::LinuxGnu
  extend ActiveSupport::Concern
  include Sys::Proc::Concerns::Helpers

  # Set process title
  #
  # @param [String] title
  # @return [String]
  def title=(title)
    helpers.get('system/generic').title = title
    prctl.set_name(title)

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
