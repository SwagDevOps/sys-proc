# frozen_string_literal: true

require 'pathname'
require 'sham'
require_relative 'local'

Sham::Config.activate!(Pathname.new(__dir__).join('..').realpath)

Object.class_eval { include Local }
