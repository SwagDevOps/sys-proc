# www.virtuouscode.com/2014/04/28/rake-part-6-clean-and-clobber/
require 'rake/clean'

[
  'pkg',
  'doc',
  "#{Project.name}.gemspec",
].each { |c| CLOBBER.include(c) }
