# frozen_string_literal: true

require_relative 'lib/sys-proc'
require 'sys/proc'
require 'pathname'

$LOAD_PATH.unshift Pathname.new(__dir__).join('rake/lib')
require 'project'

Dir.glob('rake/**/*.rake').each {|f| load(f)}
