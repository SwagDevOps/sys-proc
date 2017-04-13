# frozen_string_literal: true

require 'sys/proc/concerns'

# Provides static accesses
module Sys::Proc::Concerns::StaticInstance
  extend ActiveSupport::Concern

  module ClassMethods
    # Provides access to instance methods
    def method_missing(method, *args, &block)
      if respond_to_missing?(method)
        new.public_send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      return true if new.respond_to?(method, include_private)

      super(method, include_private)
    end
  end
end
