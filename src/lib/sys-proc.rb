# rubocop:disable Style/FileName
# frozen_string_literal: true
# rubocop:enable Style/FileName

require 'pathname'
$LOAD_PATH.unshift Pathname.new(__dir__)

if 'development' == ENV['PROJECT_MODE']
  require 'pp'
  require 'coderay'
  require 'pry/color_printer'

  def pp(obj, out=STDOUT, width=79)
    (out.isatty ? Pry::ColorPrinter : PP).pp(obj, out, width)
  end
end

require 'sys/proc'
