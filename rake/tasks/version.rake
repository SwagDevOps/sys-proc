# frozen_string_literal: true

namespace :version do
  desc 'Edit version file'
  task :edit do
    require 'tty/editor'

    TTY::Editor.open(Project.subject.VERSION.file_name)
  end
end
