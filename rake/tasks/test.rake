# frozen_string_literal: true

# More convenient than ``bundle exec``
#
# https://www.relishapp.com/rspec/rspec-core/docs/command-line/rake-task
# https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/runner.rb

desc 'Run test suites'
task :test, [:tag] do |task, args|
  options = ['-c',
             '--pattern', 'spec/**/*_spec.rb',
             '-f', 'progress',
             '-r', '%s/spec/spec_helper' % Dir.pwd]

  proc do
    require 'rspec/core'
    Project.subject

    options += ['--tag', args[:tag]] if args[:tag]
    status = RSpec::Core::Runner.run(options, $stderr, $stdout).to_i

    exit(status) unless status.zero?
  end.call
end

task :spec => [:test]
