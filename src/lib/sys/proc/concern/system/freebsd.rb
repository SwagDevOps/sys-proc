# frozen_string_literal: true

require 'sys/proc/concern/helper'
require 'sys/proc/concern/system'
require 'sys/proc/concern/system/generic'

# Provides specific Linux-GNU methods
module Sys::Proc::Concern::System::Freebsd
  extend ActiveSupport::Concern
  include Sys::Proc::Concern::Helper

  # Set program name
  #
  # @param [String] progname
  # @return [String]
  def progname=(progname)
    self.helper.get('system/generic').setprogname(progname) do |s|
      # TODO add specific method
      self.progname
    end
  end

  # Get program name
  #
  # @return [String]
  def progname
    # TODO replace by specific method
    self.helper.get('system/generic').progname
  end
end
