# frozen_string_literal: true

# Copyright (C) 2017 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require 'sys/proc/concern'
require 'sys/proc/helper'

# Provides access to helpers
module Sys::Proc::Concern::Helper

  protected

  # @return [Sys::Proc::Helper]
  def helper
    Sys::Proc::Helper.instance
  end
end
