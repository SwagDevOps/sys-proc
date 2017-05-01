# frozen_string_literal: true

# @see www.virtuouscode.com/2014/04/28/rake-part-6-clean-and-clobber/
# @todo use clobber in related rake files

require 'rake/clean'

[
  'pkg',
  'doc',
  "#{Project.name}.gemspec",
].each { |c| CLOBBER.include(c) }
