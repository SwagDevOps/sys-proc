# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require_relative '../proc'

require 'yaml'
require 'pathname'
require 'dry/inflector'

# Describe version using a YAML file.
#
# @see https://github.com/jcangas/version_info
class Sys::Proc::Version
  # Get filepath used to parse version (YAML file).
  #
  # @return [Pathname|String]
  attr_reader :file_name

  # @param [String] file_name
  def initialize(file_name = self.class.file_name)
    @file_name = file_name.freeze
    @data_loaded = self.load_file
                       .map { |k, v| self.attr_set(k, v) }.to_h
  end

  # Denote version has enough (mninimal) attributes defined.
  #
  # @return [Boolean]
  def valid?
    ![:major, :minor, :patch]
      .map { |method| public_send(method) }
      .map { |v| v.to_s.empty? ? nil : v }
      .include?(nil)
  rescue NameError
    false
  end

  # @return [String]
  def to_s
    [major, minor, patch].join('.')
  end

  # @return [Hash]
  def to_h
    data_loaded.clone.freeze
  end

  # Return the path as a String.
  #
  # @see https://ruby-doc.org/stdlib-2.5.0/libdoc/pathname/rdoc/Pathname.html#method-i-to_path
  # @return [String]
  def to_path
    file_name.to_s
  end

  class << self
    # Get default filename.
    #
    # @return [Pathname]
    def file_name
      Pathname.new(__dir__).join('version.yml')
    end
  end

  protected

  # @return [Hash]
  attr_reader :data_loaded

  # @return [Hash]
  def load_file
    YAML.load_file(file_name) || {}
  rescue Errno::ENOENT
    {}
  end

  # Define attribute (as ``ro`` attr) and set value.
  #
  # @param [String|Symbol] attr_name
  # @param [Object] attr_value
  # @return [Array]
  def attr_set(attr_name, attr_value)
    inflector = Dry::Inflector.new
    attr_name = inflector.underscore(attr_name.to_s)

    self.singleton_class.class_eval do
      attr_accessor attr_name

      protected "#{attr_name}="
    end

    self.__send__("#{attr_name}=", attr_value.freeze)

    [attr_name, attr_value.freeze].freeze
  end
end
