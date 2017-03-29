# frozen_string_literal: true

require 'pp'

# The Sys module serves as a namespace only
module Sys
end

class Sys::ProcTitle
  require 'sys/proc_title/concerns/versionable'

  VERSION_PATH_LEVELS = 3
  include Versionable
end
