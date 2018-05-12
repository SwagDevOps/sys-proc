# frozen_string_literal: true

# Copyright (C) 2017 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require 'sys/proc/concern'

# Provides static accesses
module Sys::Proc::Concern::StaticInstance
  class << self
    def included(base)
      base.extend(ClassMethods)
    end
  end

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
