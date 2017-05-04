# frozen_string_literal: true

require 'sys/proc/helper/system'

# Provides access to ``Sys::Proc::Concerns::System::Generic`` methods
class Sys::Proc::Helper::System::Generic
  def method_missing(method, *args, &block)
    if respond_to_missing?(method)
      system.public_send(method, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method, include_private = false)
    return true if system.respond_to?(method, include_private)

    super(method, include_private)
  end

  # @return [String]
  def setprogname(progname = nil, &block)
    system.progname = progname || system.default_progname

    system.progname = yield(system) if block
  end

  protected

  def system
    require 'sys/proc/concern/system/generic'

    (Class.new { include Sys::Proc::Concern::System::Generic }).new
  end
end
