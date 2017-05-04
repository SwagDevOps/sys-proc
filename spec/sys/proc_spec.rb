# frozen_string_literal: true

# class methods
describe Sys::Proc do
  { version_info: 0, new: 0, VERSION: 0 }.each do |method, n|
    it { expect(described_class).to respond_to(method) }

    it { expect(described_class).to respond_to(method).with(n).arguments }
  end

  it { expect(described_class).to define_constant('VERSION') }
end

# instance methods are available as class methods
[Sys::Proc.new, Sys::Proc].each do |subject|
  describe subject do
    { pid: 0, progname: 0, 'progname=' => 1, system: 0 }.each do |method, n|
      it { expect(subject).to respond_to(method) }

      it { expect(subject).to respond_to(method).with(n).arguments }
    end
  end
end

# examples based on system contexts
self.extend RSpec::DSL

if host_os =~ /linux(_|-)gnu/
  require 'securerandom'

  context "when #{host_os}," do
    describe Sys::Proc do
      16.times do |i|
        context '.progname' do
          let!(:progname) do
            progname = "proc_#{SecureRandom.hex}"[0..14]
            subject.progname = progname

            progname
          end

          it { expect(subject.progname).to eq(progname) }

          it { expect(subject.progname).to eq($PROGRAM_NAME) }
        end
      end

      context '.system' do
        it { expect(subject.system).to equal(:linux_gnu) }
      end

      context '.system_concern' do
        it do
          concern = Sys::Proc::Concern::System::LinuxGnu

          expect(subject.system_concern).to equal(concern)
        end
      end

      context '.progname = nil' do
        it do
          subject.progname = nil

          expect(subject.progname).to match(/^(rake|rspec)$/)
        end
      end
    end

    describe '$PROGRAM_NAME' do
      let!(:progname) do
        Sys::Proc.progname = "proc_#{SecureRandom.hex}"
        Sys::Proc.progname
      end
      let!(:subject) { $PROGRAM_NAME }

      it { expect(subject).to eq(progname) }
    end
  end
end

if host_os =~ /^freebsd/
  describe Sys::Proc do
    describe '.system' do
      it { expect(subject.system).to eq(:freebsd) }
    end
  end
end
