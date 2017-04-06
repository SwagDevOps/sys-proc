# frozen_string_literal: true

require 'sys/proc/concerns'

# Provides static accesses
module Sys::Proc::Concerns::StaticInstance
  extend ActiveSupport::Concern

  module ClassMethods
    # Provides access to instance methods
    def method_missing(method, *args, &block)
      if respond_to_missing?(method)
        instance.public_send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      result = instance.respond_to?(method)
      unless result
        return super if include_private
      end

      result
    end
  end
end
