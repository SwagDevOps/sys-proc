# A Ruby static code analyzer, based on the community Ruby style guide.
#
# @see http://batsov.com/rubocop/
# @see https://github.com/bbatsov/rubocop

namespace :cs do
  require 'rubocop/rake_task'

  {
    control: {
      description: 'Run static code analyzer',
      options: ['--fail-level', 'E'],
    },
    correct: {
      description: 'Run static code analyzer, auto-correcting offenses',
      options: ['--fail-level', 'E', '--auto-correct'],
    }
  }.each do |name, meta|
    desc meta.fetch(:description)
    task name, [:path] => ['gem:gemspec'] do |t, args|
      paths = Project.spec.require_paths

      RuboCop::RakeTask.new('%s:rubocop' % t.name) do |task|
        task.options       = meta.fetch(:options)
        task.patterns      = args[:path] ? [args[:path]] : paths
        task.fail_on_error = true
      end

      Rake::Task['%s:rubocop' % t.name].invoke
    end
  end
end
