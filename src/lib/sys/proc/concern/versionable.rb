# frozen_string_literal: true

require 'pathname'
require 'active_support/inflector'
require 'version_info'

require 'sys/proc/concern'

# Provides a standardized way to use ``VersionInfo``
#
# Define ``VERSION_PATH_LEVELS`` in order to suit your needs
module Sys::Proc::Concern::Versionable
  extend ActiveSupport::Concern

  included do
    VERSION_PATH_LEVELS = 2 unless const_defined?(:VERSION_PATH_LEVELS)
    version_info
  end

  module ClassMethods
    def version_info
      unless const_defined?(:VERSION)
        include VersionInfo

        VersionInfo.file_format = :yaml
        self.VERSION.file_name = version_filepath
        self.VERSION.load
      end

      self.VERSION.to_hash.freeze
    end

    protected

    # Get path to the ``version`` file
    #
    # @return [Pathname]
    def version_filepath
      name = ActiveSupport::Inflector.underscore(self.name)
      dirs = ['..'] * self::VERSION_PATH_LEVELS

      Pathname.new(__dir__).join(*(dirs + [name, 'version_info.yml'])).realpath
    end
  end
end
