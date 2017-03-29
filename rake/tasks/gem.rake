# frozen_string_literal: true

desc 'Build all the packages'
task :gem => ['gem:gemspec', 'gem:package']

namespace :gem do
  # desc Rake::Task[:gem].comment
  task :package => FileList.new('gem:gemspec', 'src/**/*.rb') do
    require 'rubygems/package_task'
    require 'securerandom'

    # internal namespace name
    ns = '_%s' % SecureRandom.hex(4)
    namespace ns do
      task = Gem::PackageTask.new(Project.spec)
      task.define
      # Task management
      begin
        Rake::Task['%s:package' % ns].invoke
      rescue Gem::InvalidSpecificationException => e
        STDERR.puts(e)
        exit 1
      end
      Rake::Task['clobber'].reenable
    end
  end

  desc 'Update gemspec'
  task :gemspec => "#{Project.name}.gemspec"

  desc 'Install gem'
  task :install => ['gem:package'] do
    require 'cliver'

    sh(*[Cliver.detect(:sudo),
         Cliver.detect!(:gem),
         :install,
         Project.gem].compact.map(&:to_s))
  end

  # @see http://guides.rubygems.org/publishing/
  # @see rubygems-tasks
  #
  # Code mostly base on gem executable
  desc 'Push gem up to the gem server'
  task :push => ['gem:package'] do
    ['rubygems',
     'rubygems/gem_runner',
     'rubygems/exceptions'].each { |i| require i }

    args = ['push', Project.gem]
    begin
      Gem::GemRunner.new.run(args.map(&:to_s))
    rescue Gem::SystemExitException => e
      exit e.exit_code
    end
  end
end
