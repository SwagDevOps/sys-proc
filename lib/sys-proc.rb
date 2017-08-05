# rubocop:disable Style/FileName
# frozen_string_literal: true
# rubocop:enable Style/FileName

# Copyright (C) 2017 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

if File.file?("#{__dir__}/../Gemfile.lock")
  require 'rubygems'
  require 'bundler'

  Bundler.setup(:default)
end

$LOAD_PATH.unshift __dir__

if File.file?("#{__dir__}/../Gemfile.lock")
  if 'development' == ENV['PROJECT_MODE']
    require 'bundler/setup'

    require 'pp'
    begin
      require 'coderay'
      require 'pry/color_printer'
    rescue LoadError => e
      # rubocop:disable Performance/Caller
      warn('%s: %s' % [caller[0], e.message])
      # rubocop:enable Performance/Caller
    end

    # Outputs obj to out in pretty printed format of width columns in width.
    #
    # If out is omitted, ``STDOUT`` is assumed.
    # If width is omitted, ``79`` is assumed.
    #
    # @param [Object] obj
    # @param [IO] out
    # @param [Fixnum] width
    # @see http://ruby-doc.org/stdlib-2.2.0/libdoc/pp/rdoc/PP.html
    def pp(obj, out = STDOUT, width = 79)
      args = [obj, out, width].compact
      colorable = (out.isatty and Kernel.const_defined?('Pry::ColorPrinter'))

      (colorable ? Pry::ColorPrinter : PP).pp(*args)
    end
  end
end

require File.basename(__FILE__, '.rb').tr('-', '/')
