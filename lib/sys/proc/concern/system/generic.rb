# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require_relative '../system'

# Provides generic methods
#
# This generic module can be used through the ``system/generic`` helper
# in other system(s) specific modules.
# This is the default (included) module when specific module is missing.
module Sys::Proc::Concern::System::Generic
  # Set program name
  #
  # When ``progname`` is ``nil`` will use a default ``progname``
  #
  # @param [String] progname
  # @return [String]
  def progname=(progname)
    progname ||= default_progname
    $PROGRAM_NAME = progname.to_s
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
    file = caller.last.split(/:[0-9]+:in\s/).fetch(0)

    File.basename(file, '.rb')
  end
end
