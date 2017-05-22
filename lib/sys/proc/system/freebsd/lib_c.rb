# frozen_string_literal: true

# Copyright (C) 2017 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require 'fiddle'
require 'sys/proc/system/freebsd'
require 'sys/proc/concern/helper'

# The ``getprogname()`` and ``setprogname()`` functions manipulate
# the name of the current program.
# They are used by error-reporting routines to produce consistent output.
#
# These functions first appeared in NetBSD 1.6, and made their way into
# FreeBSD 4.4.
#
# @see https://www.freebsd.org/cgi/man.cgi?query=setprogname&sektion=3
class Sys::Proc::System::Freebsd::LibC
  include Sys::Proc::Concern::Helper

  # Sets the name of the program
  # to be the last component of the progname argument.
  #
  # Since a pointer to the given string is kept as the program name,
  # it should not be modified for the rest of the program's lifetime.
  #
  # ```
  # #include <stdlib.h>
  #
  # void setprogname(const char *progname);
  # ```
  #
  # @return [Boolean]
  def setprogname(progname)
    function('setprogname', [Fiddle::TYPE_VOIDP]).call(progname.to_s)

    true
  end

  # Return the name of the program.
  #
  # If the name has not been set yet, it will return NULL.
  #
  # ```
  # #include <stdlib.h>
  #
  # const char * getprogname(void);
  # ```
  #
  # @return [String]
  def getprogname
    function('getprogname', nil, Fiddle::TYPE_VOIDP).call.to_s
  end

  protected

  # Common method binding over system libc
  #
  # @return [Fiddle::Function]
  def function(fname, args = [], ret_type = Fiddle::TYPE_INT)
    config = {
      handle: helper.get(:lib_c).dlopen[fname],
      args: args || [],
      ret_type: ret_type
    }

    Fiddle::Function.new(*config.values)
  end
end
