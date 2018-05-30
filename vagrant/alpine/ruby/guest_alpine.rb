# frozen_string_literal: true

# @see https://github.com/maier/vagrant-alpine
# rubocop:disable all

require 'vagrant-alpine/plugin'

module VagrantPlugins
  module GuestAlpine
    module Cap
      class RSync
        def self.rsync_installed(machine)
          machine.communicate.test('which rsync')
        end

        def self.rsync_install(machine)
          machine.communicate.tap do |comm|
            comm.sudo('apk --no-cache add rsync')
          end
        end
      end
    end
  end
end

# rubocop:enable all
