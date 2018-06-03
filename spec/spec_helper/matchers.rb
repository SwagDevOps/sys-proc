# frozen_string_literal: true

require_relative 'pidof'

# Sample of use:
#
# ~~~~
# it { expect(described_class).to define_constant(constant) }
# ~~~~
RSpec::Matchers.define :define_constant do |const|
  match do |subject|
    subject.const_defined?(const)
  end
end

# Sample of use:
#
# ~~~~
# it { expect(:init).to be_running }
# it { expect(:init).to be_running.with_pid(1) }
# ~~~~
#
# @see https://github.com/mizzy/serverspec/blob/master/lib/serverspec/matcher/be_running.rb
RSpec::Matchers.define :be_running do
  match do |subject|
    pids = Pidof.find(subject)
    flag = pids.size > 0

    @pid ? (flag and pids.include?(@pid)) : flag
  end

  description do
    message = 'be running'
    message += " with pid: #{@pid}" if @pid
    message
  end

  chain :with_pid do |pid|
    @pid = pid
  end
end
