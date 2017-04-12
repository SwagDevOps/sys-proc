# frozen_string_literal: true

require 'sys/proc/concerns'
require 'sys/proc/helpers'

# Provides access to helpers
module Sys::Proc::Concerns::Helpers
  extend ActiveSupport::Concern

  protected

  # @return [Sys::Proc::Helpers]
  def helpers
    Sys::Proc::Helpers
  end
end
