# frozen_string_literal: true

# Copyright (C) 2017 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require 'pathname'

require 'sys/proc/concern'

# Provides a standardized way to use ``VersionInfo``
module Sys::Proc::Concern::Versionable
  extend ActiveSupport::Concern

  included { version_info }

  module ClassMethods
    def version_info
      unless const_defined?(:VERSION)
        require 'version_info'
        include VersionInfo
        # @todo deternmine format from extension?
        VersionInfo.file_format = :yaml

        self.VERSION.file_name = version_basedir.join('version_info.yml')
        self.VERSION.load
      end

      self.VERSION.to_hash.freeze
    end

    protected

    # Extract basedir from ``caller``
    #
    # @raise [Errno::ENOENT]
    # @return [Pathname]
    def version_basedir
      basedir = caller.grep(/in `include'/)
                      .fetch(0)
                      .split(/\.rb:[0-9]+:in\s+/).fetch(0)

      Pathname.new(basedir).realpath
    end
  end
end
