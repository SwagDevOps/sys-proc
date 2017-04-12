# frozen_string_literal: true

require 'sys/proc/concerns/system'

# Provides generic methods
#
# This generic module should be used
# as a template to derivate system(s) specific modules.
# This is the default included module when specific module is missing.
module Sys::Proc::Concerns::System::Generic
  extend ActiveSupport::Concern

  # Set process title
  #
  # @param [String] title
  # @return [String]
  def title=(title)
    Process.setproctitle(title.to_s)
    $PROGRAM_NAME = title.to_s

    title
  end

  # Get process title
  #
  # @return [String]
  def title
    $PROGRAM_NAME
  end
end
