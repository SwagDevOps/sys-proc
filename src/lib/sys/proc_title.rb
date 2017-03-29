# frozen_string_literal: true

require 'pathname'
require 'active_support/inflector'
require 'version_info'

# The Sys module serves as a namespace only
module Sys
end

class Sys::ProcTitle
  class << self
    # @return [Hash]
    def version_info
      unless self.const_defined?(:VERSION)
        include VersionInfo

        VersionInfo.file_format = :yaml
        VERSION.file_name = self.version_filepath
        VERSION.load
      end

      VERSION.to_hash.freeze
    end

    protected

    # Get path to the ``version`` file
    #
    # @return [Pathname]
    def version_filepath
      name = ActiveSupport::Inflector.underscore(self.name)

      Pathname.new(__dir__).join('..', name, 'version_info.yml').realpath
    end
  end

  # registers version_info
  self.version_info
end
