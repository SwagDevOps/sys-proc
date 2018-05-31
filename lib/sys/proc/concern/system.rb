# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require_relative '../concern'
require_relative 'helper'

# Provides Operating System related methods
#
# This ``Concern`` loads system (OS) related sub-concern (specialisation)
module Sys::Proc::Concern::System
  include Sys::Proc::Concern::Helper

  class << self
    include Sys::Proc::Concern::Helper

    def included(base)
      # Related concern is included recursively

      base.include(base.new.__send__(:system_concern))
    end
  end

  # Identify operating system
  #
  # @return [Symbol]
  def system
    (@system || helper.get(:system).identify).to_sym
  end

  protected

  # Get operating system related concern
  #
  # @return [Module]
  def system_concern
    inflector = helper.get(:inflector)

    begin
      inflector.resolve("sys/proc/concern/system/#{system}")
    rescue LoadError
      # m = /^cannot load such file -- #{Regexp.quote(system)}/ =~ e.to_s
      inflector.resolve('sys/proc/concern/system/generic')
    end
  end
end
