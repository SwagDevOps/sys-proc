# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require 'fiddle'
require_relative '../linux_gnu'
require_relative '../../helper'

# Operations on a process
#
# @see http://man7.org/linux/man-pages/man2/prctl.2.html
#
# ~~~~
# #include <sys/prctl.h>
#
# int prctl(int option, unsigned long arg2, unsigned long arg3,
#           unsigned long arg4, unsigned long arg5);
# ~~~~
class Sys::Proc::System::LinuxGnu::Prctl
  include Sys::Proc::Concern::Helper

  # Set the name of the calling threadThe attribute is
  # likewise accessible via /proc/self/task/[tid]/comm, where tid
  # is the name of the calling thread.
  PR_SET_NAME = 15 # (since Linux 2.6.9)

  # Return the name of the calling thread, in the buffer pointed
  # to by (char *) arg2. The buffer should allow space for up to
  # 16 bytes; the returned string will be null-terminated.
  PR_GET_NAME = 16 # (since Linux 2.6.11)

  # Set the name of the calling thread
  #
  # @param [String] name
  # @return [Boolean]
  def setprogname(name)
    name = name.to_s

    call(PR_SET_NAME, name).zero?
  end

  # Return the name of the calling thread
  #
  # @return [String]
  def getprogname
    ptr = Fiddle::Pointer.malloc(32, Fiddle::RUBY_FREE.to_i)

    call(PR_GET_NAME, ptr.to_i)
    ptr.to_s
  end

  # prctl() is called with a first argument describing what to do (with
  # values defined in <linux/prctl.h>), and further arguments with a
  # significance depending on the first one.
  #
  # @return [Fixnum]
  def call(*args)
    args += ([0] * 5).slice(args.size..-1)

    function.call(*args)
  end

  protected

  # @return [Fiddle::Function]
  def function
    config = {
      handle: helper.get(:lib_c).dlopen['prctl'],
      args: [Fiddle::TYPE_INT, Fiddle::TYPE_VOIDP,
             Fiddle::TYPE_LONG, Fiddle::TYPE_LONG, Fiddle::TYPE_LONG],
      ret_type: Fiddle::TYPE_INT
    }

    Fiddle::Function.new(*config.values)
  end
end
