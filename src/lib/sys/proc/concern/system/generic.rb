# frozen_string_literal: true

require 'sys/proc/concern/system'

# Provides generic methods
#
# This generic module can be used through the ``system/generic`` helper
# in other system(s) specific modules.
# This is the default (included) module when specific module is missing.
module Sys::Proc::Concern::System::Generic
  extend ActiveSupport::Concern

  # Set program name
  #
  # When ``progname`` is ``nil`` will use a default ``progname``
  #
  # @param [String] title
  # @return [String]
  def progname=(progname)
    progname ||= default_progname
    $PROGRAM_NAME = progname.to_s

    progname
  end

  # Get program name
  #
  # @return [String]
  def progname
    $PROGRAM_NAME
  end

  # Get default program name
  #
  # @return [String]
  def default_progname
    file = caller[-1].split(/:[0-9]+:in\s/).fetch(0)

    File.basename(file, '.rb')
  end
end
