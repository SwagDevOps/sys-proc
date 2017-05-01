# frozen_string_literal: true

require 'pathname'
require 'yaml'

unless Kernel.const_defined?('Project')
  module Project
  end
end

# Vagrant based helper
#
# Sample use in Rake task:
#
# ```
# require 'project/vagrant_helper'
# vagrant = Project::VagrantHelper
#
# if vagrant.boxes? and helper.executable
#    file helper.installable => helper.installer do
#    helper.install
# end
# ```
module Project::VagrantHelper
  class << self
    unless Kernel.const_defined?('Vagrant')
      require 'cliver'
      require 'rake/file_utils'

      include FileUtils

      # Absolute path to the vagrant executable
      #
      # @return [String|nil]
      def executable
        Cliver.detect(:vagrant)
      end

      def has_executable?
        !!(executable)
      end

      # Run the vagrant command +cmd+.
      #
      # @see https://github.com/ruby/rake/blob/master/lib/rake/file_utils.rb
      def execute(*cmd, &block)
        Bundler.with_clean_env do
          cmd = [executable] + cmd

          sh(*cmd, &block)
        end
      end
    end

    # @return [Pathname]
    def installer
      Pathname.new(__FILE__)
    end

    # @return [Pathname]
    def installable
      Pathname.new(Dir.pwd).join('Vagrantfile')
    end

    # Install a new Vagrantfile
    def install
      installable.write(installer.read)
    end

    # Get boxes configuration
    #
    # @return [Hash]
    def boxes
      results = {}
      Dir.glob('%s/vagrant/*.yml' % Dir.pwd).each do |path|
        path = Pathname.new(path).realpath
        box_name = path.basename('.*').to_s

        results[box_name] = YAML.load_file(path)
      end

      results
    end

    def has_boxes?
      boxes.size > 0
    end

    alias :file :installable
  end
end

# This is the real Vagrantfile (executed in a Vagrant context)
if Kernel.const_defined?('Vagrant')
  boxes = Project::VagrantHelper.boxes

  Vagrant.configure(2) do |config|
    boxes.each do |box, box_config|
      if box_config['synced_folder']
        config.vm.public_send(:synced_folder,
                              *(box_config['synced_folder'][0] || []),
                              **(box_config['synced_folder'][1] || {}))
      end

      machine_name = box
      config.vm.define machine_name, autostart: false do |machine|
        machine.vm.box = box_config.fetch('image')

        (box_config['providers'] || {})
          .each do |provider, provider_config|
          config.vm.provider provider do |vb|
            provider_config.each do |pc_type, pconfigs|
              next unless ['vm', 'customize'].include?(pc_type)

              pconfigs.each do |c|
                c = ['customize', [c], {}] if pc_type == 'customize'

                configurable = vb if pc_type == 'customize'
                configurable = config.vm if pc_type == 'vm'

                configurable.public_send(c[0], *(c[1]), **(c[2] || {}))
              end
            end
          end
        end

        (box_config['provisions'] || {}).each do |provision|
          machine.vm.public_send(:provision, *(provision[0]), **(provision[1]))
        end

        box_config.each do |k, v|
          next unless ['provision', 'guest'].include?(k)

          if v.is_a?(Array)
            machine.vm.public_send('%s' % k, *(v[0]), **(v[1]))
          else # settings
            machine.vm.public_send('%s=' % k, v)
          end
        end
      end
    end
  end
end
