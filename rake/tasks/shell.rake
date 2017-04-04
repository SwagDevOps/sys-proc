# frozen_string_literal: true

# More convenient than ``bundle exec pry``
desc 'Start ruby REPL'
task :shell do
  require 'pry'
  require 'rainbow'

  proc do
    patch = defined?(RUBY_PATCHLEVEL) ? 'p%s' % RUBY_PATCHLEVEL : nil
    puts Rainbow(['Ruby',
                  '%s%s' % [RUBY_VERSION, patch],
                  '(%s revision %s)' % [RUBY_RELEASE_DATE, RUBY_REVISION],
                  '[%s]' % RUBY_PLATFORM].join(' ')).green
  end.call if Project.subject

  Pry.start
end
