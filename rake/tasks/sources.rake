# frozen_string_literal: true

namespace :sources do
  desc 'Apply license on source files'
  task license: ['gem:gemspec'] do
    require 'project/licenser'

    Project::Licenser.process do |process|
      # @todo use ``Gem::Specification``
      process.patterns += ['./bin/*']
    end
  end
end
