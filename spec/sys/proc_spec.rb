# frozen_string_literal: true

# class methods
describe Sys::Proc do
  [:version_info, :instance, 'VERSION'].each do |method|
    it { expect(described_class).to respond_to(method) }
  end

  it { expect(described_class).to define_constant('VERSION') }
end

# instance methods are available as class methods
[Sys::Proc.instance, Sys::Proc].each do |subject|
  describe subject do
    [:pid, :name, 'name=', :host_os].each do |method|
      it { expect(subject).to respond_to(method) }
    end
  end
end

# operating system contexts
describe Sys::Proc do
  if :linux_gnu == described_class.host_os
    context 'when %s' % described_class.host_os do
      # @todo
    end
  end
end
