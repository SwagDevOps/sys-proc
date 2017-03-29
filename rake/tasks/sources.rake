# frozen_string_literal: true

namespace :sources do
  desc 'Apply license on source files'
  task license: ['gem:gemspec'] do
    require 'project/licenser'

    Project::Licenser.process do |process|
      process.patterns += ['src/bin/*']
    end
  end
end
