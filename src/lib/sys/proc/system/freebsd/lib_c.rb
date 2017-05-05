# frozen_string_literal: true

require 'fiddle'
require 'sys/proc/system/freebsd'

# The ``getprogname()`` and ``setprogname()`` functions manipulate
# the name of the current program.
# They are used by error-reporting routines to produce consistent output.
#
# These functions first appeared in NetBSD 1.6, and made their way into
# FreeBSD 4.4.
#
# @see https://www.freebsd.org/cgi/man.cgi?query=setprogname&sektion=3
class Sys::Proc::System::Freebsd::LibC
  def initialize
    @lib = dlopen
  end

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
    name = progname.to_s
    func = make_function('setprogname', [Fiddle::TYPE_VOIDP])

    func.call(name)
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
    func = make_function('getprogname', nil, Fiddle::TYPE_VOIDP)

    func.call.to_s
  end

  protected

  # Load the shared library
  #
  # @return [Fiddle::Handle]
  def dlopen
    Fiddle.dlopen('libc.so.7')
  end

  # Common method binding over system libc
  #
  # @return [Fiddle::Function]
  def make_function(fname, args = [], ret_type = Fiddle::TYPE_INT)
    config = {
      handle: @lib[fname],
      args: args || [],
      ret_type: ret_type
    }

    Fiddle::Function.new(*config.values)
  end
end
