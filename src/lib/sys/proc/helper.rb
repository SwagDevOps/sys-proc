# frozen_string_literal: true

require 'sys/proc'

# Provides access to helper classes
class Sys::Proc::Helper
  def initialize
    @items = {
      inflector: proc do
        require 'sys/proc/helper/inflector'

        Inflector.new
      end.call
    }
  end

  # @param [String|Symbol] name
  # @return [Object]
  def get(name)
    name = name.to_sym

    return items[name] if items[name]

    @items[name] = inflector.load("sys/proc/helper/#{name}").new
  end

  protected

  attr_reader :items

  # @return [Sys::Proc::Helper::Inflector]
  def inflector
    items.fetch(:inflector)
  end

  class << self
    # Provides access to instance methods
    def method_missing(method, *args, &block)
      if respond_to_missing?(method)
        self.new.public_send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      return true if self.new.respond_to?(method, include_private)

      super(method, include_private)
    end
  end
end
