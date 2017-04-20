# frozen_string_literal: true

# (Class.new { include Sys::Proc::Concerns::System::Generic }.title = title)

require 'sys/proc'

# Provides access to helpers
class Sys::Proc::Helper
  def initialize
    @inflector = proc do
      require 'active_support/inflector'
      ActiveSupport::Inflector
    end.call

    @items = { inflector: inflector }
  end

  # @param [String|Symbol] name
  # @return [Object]
  def get(name)
    name = name.to_sym

    return items[name] if items[name]

    r = "sys/proc/helper/#{name}"
    require r
    @items[name] = inflector.constantize(inflector.classify(r)).new
  end

  protected

  attr_reader :items

  attr_reader :inflector

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
