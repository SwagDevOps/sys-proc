# frozen_string_literal: true

require 'sys/proc/helper'

class Sys::Proc::Helper::Inflector
  def initialize
    require 'active_support/inflector'

    @inflector = ActiveSupport::Inflector
  end

  # Load constant from a loadable/requirable path
  #
  # @param [String] loadable
  # @return [Object]
  def load(loadable)
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
