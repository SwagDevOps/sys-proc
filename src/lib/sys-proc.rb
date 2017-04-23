# rubocop:disable Style/FileName
# frozen_string_literal: true
# rubocop:enable Style/FileName

$LOAD_PATH.unshift __dir__

if 'development' == ENV['PROJECT_MODE']
  require 'pp'
  require 'coderay'
  require 'pry/color_printer'

  def pp(obj, out=STDOUT, width=nil)
    args = [obj, out, width].compact

    (out.isatty ? Pry::ColorPrinter : PP).pp(*args)
  end
end

require File.basename(__FILE__, '.rb').gsub('-', '/')
