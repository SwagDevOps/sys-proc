# frozen_string_literal: true

require 'fiddle'
require 'sys/proc/system/linux_gnu'
require 'sys/proc/system/linux_gnu/prctl'

include Sys::Proc::System::LinuxGnu

# Provides compatibilty with BSD systems
#
# Expected methods are:
#
# * ``setprogname``
# * ``getprogname``
class Sys::Proc::System::LinuxGnu::LibC
  def initialize
    @prctl = Prctl.new
  end

  # Sets the name of the program
  #
  # @return [Boolean]
  def setprogname(progname)
    prctl.set_name(progname)
  end

  # Return the name of the program.
  #
  # @return [String]
  def getprogname
    prctl.get_name
  end

  protected

  # @return [Sys::Proc::System::LinuxGnu::Prctl]
  attr_reader :prctl
end
