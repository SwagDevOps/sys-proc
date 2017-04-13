# frozen_string_literal: true

# class methods
describe Sys::Proc do
  [:version_info, :new, 'VERSION'].each do |method|
    it { expect(described_class).to respond_to(method) }
  end

  it { expect(described_class).to define_constant('VERSION') }
end

# instance methods are available as class methods
[Sys::Proc.new, Sys::Proc].each do |subject|
  describe subject do
    [:pid, :title, 'title=', :system].each do |method|
      it { expect(subject).to respond_to(method) }
    end
  end
end

# operating system contexts
describe Sys::Proc do
  self.extend RSpec::DSL

  if ['linux-gnu'].include?(host_os)
    context "when #{host_os}" do
      # @todo
    end
  end
end
