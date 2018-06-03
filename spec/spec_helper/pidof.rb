# frozen_string_literal: true

# Find the pid(s) of a process
#
# Sample of use:
#
# ```
# Pidof.find(:systemd)
# ```
class Pidof
  class << self
    def find(progname)
      require 'open3'

      Open3.capture3(executable, progname.to_s)[0]
           .chomp.split(/\s+/).map(&:to_i)
    end

    def executable
      require 'cliver'

      Cliver.detect!(:pidof)
    end
  end
end
