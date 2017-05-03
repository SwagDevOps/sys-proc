# frozen_string_literal: true

require 'sys/proc/concern/system'

# Provides generic methods
#
# This generic module can be used through the ``system/generic`` helper
# in other system(s) specific modules.
# This is the default (included) module when specific module is missing.
module Sys::Proc::Concern::System::Generic
  extend ActiveSupport::Concern

  # Set process title
  #
  # When an ``title`` is ``nil`` will
  #
  # @param [String] title
  # @return [String]
  def title=(title)
    title ||= default_title
    $PROGRAM_NAME = title.to_s

    title
  end

  # Get process title
  #
  # @return [String]
  def title
    $PROGRAM_NAME
  end

  # Get default title
  #
  # @return [String]
  def default_title
    file = caller[-1].split(/:[0-9]+:in\s/).fetch(0)

    File.basename(file, '.rb')
  end
end
