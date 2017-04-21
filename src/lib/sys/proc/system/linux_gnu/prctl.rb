# frozen_string_literal: true

require 'fiddle'
require 'pathname'

require 'sys/proc/system/linux_gnu'

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
  attr_reader :function

  # Set the name of the calling threadThe attribute is
  # likewise accessible via /proc/self/task/[tid]/comm, where tid
  # is the name of the calling thread.
  PR_SET_NAME = 15 # (since Linux 2.6.9)

  # Return the name of the calling thread, in the buffer pointed
  # to by (char *) arg2. The buffer should allow space for up to
  # 16 bytes; the returned string will be null-terminated.
  PR_GET_NAME = 16 # (since Linux 2.6.11)

  def initialize
    @function = make_function
  end

  # Set the name of the calling thread
  #
  # @param [String] name
  # @return [Boolean]
  # rubocop:disable Style/AccessorMethodName
  def set_name(name = nil)
    name ||= Pathname.new($PROGRAM_NAME).basename('.rb').to_s
    name = name.to_s

    if call(PR_SET_NAME, name).zero?
      $PROGRAM_NAME = name
      true
    else
      false
    end
  end
  # rubocop:enable Style/AccessorMethodName

  # Return the name of the calling thread
  #
  # @return [String]
  # rubocop:disable Style/AccessorMethodName
  def get_name
    ptr = Fiddle::Pointer.malloc(32, Fiddle::RUBY_FREE.to_i)

    call(PR_GET_NAME, ptr.to_i)
    ptr.to_s
  end
  # rubocop:enable Style/AccessorMethodName

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
  def make_function
    config = {
      handle: Fiddle::Handle['prctl'],
      args: [Fiddle::TYPE_INT, Fiddle::TYPE_VOIDP,
             Fiddle::TYPE_LONG, Fiddle::TYPE_LONG, Fiddle::TYPE_LONG],
      ret_type: Fiddle::TYPE_INT
    }

    Fiddle::Function.new(*config.values)
  end
end
