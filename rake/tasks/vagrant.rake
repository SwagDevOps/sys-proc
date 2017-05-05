# frozen_string_literal: true

require 'rake/clean'
require 'project/vagrant_helper'
vagrant = Project::VagrantHelper

if vagrant.has_boxes? and vagrant.has_executable?
  CLOBBER.include(vagrant.file.basename)

  file vagrant.file.basename => vagrant.installer do
    vagrant.install
  end

  namespace :vagrant do
    task init: [vagrant.file.basename]

    {
      'rsync-auto' => 'Watch all rsync synced folders',
      status: 'Current machine states',
    }.each do |k, v|
      desc v
      task k => [vagrant.file.basename] do
        begin
          vagrant.execute(k.to_s)
        rescue SystemExit, Interrupt
        end
      end
    end
  end

  namespace :vm do
    vagrant.boxes.each do |box, box_config|
      namespace box do
        [:up, :halt, :reload, :ssh, :provision, :rsync].each do |command|
          desc "%s #{box}" % command.to_s.gsub(/(\w+)/) {|s| s.capitalize}
          task command => [vagrant.file.basename] do
            vagrant.execute(command.to_s, box)
          end
        end

        namespace :ssh do
          (box_config['ssh_commands'] || {}).each do |name, command|
            next if command.to_s.empty?

            desc 'Execute `%s` named command' % name
            task name => [vagrant.file.basename] do
              vagrant.execute('ssh', box, '-c', command)
            end
          end
        end
      end
    end
  end
end
