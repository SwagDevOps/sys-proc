# frozen_string_literal: true

require 'sys/proc/concern'
require 'sys/proc/concern/helper'

# Provides Operating System related methods
#
# This ``Concern`` loads system (OS) related sub-concern (specialisation)
module Sys::Proc::Concern::System
  extend ActiveSupport::Concern
  include Sys::Proc::Concern::Helper

  # Related concern is included recursively
  included { include system_concern }

  # Identify operating system
  #
  # @return [Symbol]
  def system
    (@system || helper.get(:system).identify).to_sym
  end

  # Get operating system related concern
  #
  # @return [Module]
  def system_concern
    inflector = helper.get(:inflector)

    begin
      inflector.resolve("sys/proc/concern/system/#{system}")
    rescue LoadError => e
      # m = /^cannot load such file -- #{Regexp.quote(system)}/ =~ e.to_s

      inflector.resolve('sys/proc/concern/system/generic')
    end
  end
end
