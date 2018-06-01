# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require_relative '../proc'

# Provides access to helper classes
class Sys::Proc::Helper
  include ::Singleton

  protected def initialize
    @items = {
      inflector: proc do
        require_relative 'helper/inflector'

        Inflector.new
      end.call
    }

    super
  end

  # @param [String|Symbol] name
  # @return [Object]
  #
  # @raise [NotImplementedError]
  def get(name)
    name = name.to_sym

    return items[name] if items[name]

    begin
      @items[name] = inflector.resolve("sys/proc/helper/#{name}").new
    rescue LoadError
      raise NotImplementedError, "helper not loadable: #{name}"
    end
  end

  protected

  attr_reader :items

  # @return [Hash]
  def to_h
    items
  end

  # @return [Sys::Proc::Helper::Inflector]
  def inflector
    to_h.fetch(:inflector)
  end
end
