# rubocop:disable Style/FileName
# frozen_string_literal: true
# rubocop:enable Style/FileName

$LOAD_PATH.unshift __dir__

if 'development' == ENV['PROJECT_MODE']
  require 'pp'
  begin
    require 'coderay'
    require 'pry/color_printer'
  rescue LoadError => e
    warn("%s: %s" % [caller[0], e.message])
  end

  def pp(obj, out=STDOUT, width=nil)
    args = [obj, out, width].compact
    colorable = (out.isatty and Kernel.const_defined?('Pry::ColorPrinter'))

    (colorable ? Pry::ColorPrinter : PP).pp(*args)
  end
end

require File.basename(__FILE__, '.rb').gsub('-', '/')
