# frozen_string_literal: true

# Namespace
module Sys::Proc::Helpers::System
end

# Provides access to ``Sys::Proc::Concerns::System::Generic`` methods
class Sys::Proc::Helpers::System::Generic
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

  protected

  def system
    require 'sys/proc/concerns/system/generic'

    (Class.new { include Sys::Proc::Concerns::System::Generic }).new
  end
end
