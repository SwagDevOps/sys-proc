# frozen_string_literal: true

# class methods
describe Sys::Proc do
  {version_info: 0, new: 0, VERSION: 0}.each do |method, n|
    it { expect(described_class).to respond_to(method) }

    it { expect(described_class).to respond_to(method).with(n).arguments }
  end

  it { expect(described_class).to define_constant('VERSION') }
end

# instance methods are available as class methods
[Sys::Proc.new, Sys::Proc].each do |subject|
  describe subject do
    {pid: 0, title: 0, 'title=' => 1, system: 0}.each do |method, n|
      it { expect(subject).to respond_to(method) }

      it { expect(subject).to respond_to(method).with(n).arguments }
    end
  end
end

# operating system contexts
describe Sys::Proc do
  self.extend RSpec::DSL

  if ['linux-gnu'].include?(host_os)
    require 'securerandom'

    context "when #{host_os}" do
      describe Sys::Proc do
        16.times do |i|
          context "in iteration #{(i+1)}" do
            context '#title' do
              let!(:title) \
              { subject.title = "proc_#{SecureRandom.hex}"[0..14] }

              it { expect(subject.title).to eq(title) }
            end
          end
        end
      end
    end
  end
end
