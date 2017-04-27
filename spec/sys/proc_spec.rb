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

# examples based on system contexts
self.extend RSpec::DSL

if ['linux-gnu'].include?(host_os)
  require 'securerandom'

  context "when #{host_os}," do
    describe Sys::Proc do
      16.times do |i|
        context '.title' do
          let!(:title) do
            title = "proc_#{SecureRandom.hex}"[0..14]
            subject.title = title

            title
          end

          it { expect(subject.title).to eq(title) }

          it { expect(subject.title).to eq($PROGRAM_NAME) }
        end
      end

      context '.system' do
        it { expect(subject.system).to equal(:linux_gnu) }
      end

      context '.system_concern' do
        it do
          expect(subject.system_concern)
            .to equal(Sys::Proc::Concern::System::LinuxGnu)
        end
      end

      context '.title = nil' do
        it do
          subject.title = nil

          expect(subject.title).to match(/(rake|rspec)/)
        end
      end
    end

    describe '$PROGRAM_NAME' do
      let!(:title) do
        Sys::Proc.title = "proc_#{SecureRandom.hex}"
        Sys::Proc.title
      end
      let!(:subject) { $PROGRAM_NAME }

      it { expect(subject).to eq(title) }
    end
  end
end
