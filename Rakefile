# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'pathname'

$LOAD_PATH.unshift Pathname.new(__dir__).join('rake', 'lib')

require 'project'

Dir.glob('rake/**/*.rake').each {|f| load(f)}
