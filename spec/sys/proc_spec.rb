# frozen_string_literal: true

require 'securerandom'

# class methods
describe Sys::Proc do
  it { expect(described_class).to respond_to(:new).with(0).arguments }
  it { expect(described_class).to define_constant('VERSION') }

  context '::VERSION' do
    it do
      expect(described_class.const_get(:VERSION)).to be_a(Sys::Proc::Version)
    end
  end
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

describe Sys::Proc do
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

# examples based on system contexts
self.extend RSpec::DSL

if host_os =~ Regexp.union([/^linux-gnu$/,
                            /^freebsd([0-9]+\.[0-9]+)*$/])
  context "when #{host_os}," do
    describe Sys::Proc do
      # context '.system' do
      #   it { expect(subject.system).to equal(:linux_gnu) }
      # end

      context '.system_concern.to_s' do
        it do
          concern = {
            linux_gnu: 'Sys::Proc::Concern::System::LinuxGnu',
            freebsd:   'Sys::Proc::Concern::System::Freebsd'
          }.fetch(Sys::Proc.system)

          expect(subject.__send__(:system_concern).to_s).to eq(concern)
        end
      end

      16.times do |i|
        context '.progname' do
          let!(:progname) do
            progname = "proc_#{SecureRandom.hex}"[0..14]
            subject.progname = progname

            progname
          end

          it { expect(subject.progname).to eq(progname) }

          it { expect(subject.progname).to eq($PROGRAM_NAME) }

          next if /^linux_gnu$/ !~ Sys::Proc.system.to_s

          it { expect(subject.progname).to be_running.with_pid(subject.pid) }
        end
      end
    end
  end
end
