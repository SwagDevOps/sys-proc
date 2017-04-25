# frozen_string_literal: true

require 'sys/proc/concern'
require 'sys/proc/helper'

# Provides access to helpers
module Sys::Proc::Concern::Helper
  extend ActiveSupport::Concern

  protected

  # @return [Sys::Proc::Helper]
  def helper
    Sys::Proc::Helper.instance
  end
end
