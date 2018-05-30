# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

# System helper
class Sys::Proc::Helper::System
  # Identify operating system
  #
  # @return [Symbol]
  def identify
    (RbConfig::CONFIG['host_os'] || 'generic')
      .tr('-', '_')
      .gsub(/[0-9]+(\.[0-9]+)*$/, '')
      .to_sym
  end
end
