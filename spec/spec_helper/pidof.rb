# frozen_string_literal: true

require 'open3'
require 'cliver'

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
      Open3.capture3(executable, progname.to_s)[0]
           .chomp.split(/\s+/).map(&:to_i)
    end

    def executable
      Cliver.detect!(:pidof)
    end
  end
end
