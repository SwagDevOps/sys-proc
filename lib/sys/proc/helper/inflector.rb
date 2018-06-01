# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require_relative '../helper'

# Inflector built on top of ``Dry::Inflector``
class Sys::Proc::Helper::Inflector
  def initialize
    require 'dry/inflector'

    @inflector = Dry::Inflector.new
  end

  # Load constant from a loadable/requirable path
  #
  # @param [String] loadable
  # @return [Object]
  def resolve(loadable)
    require loadable

    @inflector.constantize(@inflector.classify(loadable))
  end

  def method_missing(method, *args, &block)
    if respond_to_missing?(method)
      @inflector.public_send(method, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method, include_private = false)
    return true if @inflector.respond_to?(method, include_private)

    super(method, include_private)
  end
end
