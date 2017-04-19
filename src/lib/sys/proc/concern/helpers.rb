# frozen_string_literal: true

require 'sys/proc/concern'
require 'sys/proc/helpers'

# Provides access to helpers
module Sys::Proc::Concern::Helpers
  extend ActiveSupport::Concern

  protected

  # @return [Sys::Proc::Helpers]
  def helpers
    Sys::Proc::Helpers
  end
end
