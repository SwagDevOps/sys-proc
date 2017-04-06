# frozen_string_literal: true

require 'sys/proc/concerns/system'

# Provides specific Linux-GNU methods
module Sys::Proc::Concerns::System::LinuxGnu
  extend ActiveSupport::Concern

  protected

  # @todo implement
  def set_proc_name(name)
    name
  end

  # @todo implement
  def get_proc_name
    nil
  end
end
