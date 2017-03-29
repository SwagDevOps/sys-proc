# coding: utf-8
# frozen_string_literal: true
#
# see: https://gist.github.com/chetan/1827484

desc "Generate documentation (using YARD)"
task :doc do
  [:pathname, :yard, :securerandom].each { |req| require req.to_s }

  # internal task name
  tname = 'doc:build:%s' % SecureRandom.hex(4)
  # documented paths
  paths   = ['src/lib']
  # extra static files to be included (eg. FAQ)
  statics = Dir.glob(['README.*', 'README'])

  YARD::Rake::YardocTask.new(tname) do |t|
    t.files = paths.map do |path|
      Pathname.new(path).join('**', '*.rb').to_s
    end

    t.options = ['-o', 'doc',
                 '--markup-provider=redcarpet',
                 '--markup=markdown',
                 '--charset', 'utf-8',
                 '--title',
                 '%s v%s' % [Project.name, Project.version_info[:version]]]

    t.options += ['--files', statics.join(',')] unless statics.empty?
  end

  Rake::Task[tname].invoke

  Proc.new do
    threads = []
    Dir.glob('doc/**/*.html').each do |f|
      threads << Thread.new do
        f = Pathname.new(f)
        s = f.read.gsub(/^\s*<meta charset="[A-Z]+-{0,1}[A-Z]+">/,
                        '<meta charset="UTF-8">')
        f.write(s)
      end
    end
    threads.map { |t| t.join }
  end
end
