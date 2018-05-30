# frozen_string_literal: true

require_relative 'lib/sys-proc'
require 'sys/proc'
require 'kamaze/project'

Sys::Proc.progname = nil

Kamaze.project do |project|
  project.subject = Sys::Proc
  project.name    = 'sys-proc'
  project.tasks   = [
    'cs:correct', 'cs:control',
    'cs:pre-commit',
    'doc', 'doc:watch',
    'gem',
    'shell', 'sources:license',
    'test',
    'vagrant', 'version:edit',
  ]
end.load!

task default: [:gem]

if project.path('spec').directory?
  task :spec do |task, args|
    Rake::Task[:test].invoke(*args.to_a)
  end
end
