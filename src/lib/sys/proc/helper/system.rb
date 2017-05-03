# frozen_string_literal: true

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
