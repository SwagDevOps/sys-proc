# frozen_string_literal: true

require 'ostruct'

# Generic struct (ala OpenStruct)
class FactoryStruct < OpenStruct
  # rubocop:disable Style/MissingRespondToMissing

  # Introduces some strictness on ``OpenStruct#method_missing``
  #
  # @see https://apidock.com/ruby/OpenStruct/method_missing
  # @return [Object]
  def method_missing(method, *args)
    if method[-1] != '='
      unless self.to_h.include?(method.to_sym)
        message = "undefined method `#{method}' for #{self}"

        raise NoMethodError, message, caller(1)
      end
    end

    super
  end
  # rubocop:enable Style/MissingRespondToMissing
end
