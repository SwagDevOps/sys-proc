# rubocop:disable Style/FileName
# frozen_string_literal: true
# rubocop:enable Style/FileName

# Copyright (C) 2017 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

$LOAD_PATH.unshift(__dir__)

lock = Dir.chdir("#{__dir__}/..") do
  [['gems.rb', 'gems.locked'], ['Gemfile', 'Gemfile.lock']]
    .map { |m| Dir.glob(m).size >= 2 }
    .include?(true)
end
mode = (ENV['PROJECT_MODE'] || lock ? 'development' : 'production').to_sym

if lock
  require 'rubygems'
  require 'bundler/setup'
end

if lock and :development == mode
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
