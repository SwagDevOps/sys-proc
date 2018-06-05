# frozen_string_literal: true

require 'sys/proc'

# class methods
describe Sys::Proc do
  it { expect(described_class).to respond_to(:new).with(0).arguments }
  it { expect(described_class).to define_constant('VERSION') }

  context '::VERSION' do
    it do
      expect(described_class).to define_constant(:VERSION)
      expect(described_class.const_get(:VERSION)).to be_a(Sys::Proc::Version)
    end
  end
end

# instance methods are available as class methods
describe Sys::Proc do
  [:subject, :described_class].each do |m|
    it { expect(public_send(m)).to respond_to(:pid).with(0).arguments }
    it { expect(public_send(m)).to respond_to(:progname).with(0).arguments }
    it { expect(public_send(m)).to respond_to('progname=').with(1).arguments }
    it { expect(public_send(m)).to respond_to(:system).with(0).arguments }
    it { expect(public_send(m)).to respond_to(:time).with(0).arguments }
  end
end

describe Sys::Proc do
  context '.time' do
    it { expect(described_class.time).to be_a(Float) }
  end

  context '.time.to_i' do
    let!(:uptime) { Process.clock_gettime(Process::CLOCK_MONOTONIC) }

    it { expect(described_class.time.to_i).to eq(uptime.to_i) }
  end
end

describe Sys::Proc do
  let(:matcher) { /^(ruby(_executable(_hooks){0,1}){0,1}|rake|rspec)$/ }
  # Using a default progname
  before(:all) { described_class.progname = nil }

  context '.progname' do
    it { expect(subject.progname).to match(matcher) }
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

if host_match?([/^linux-gnu$/, /^freebsd([0-9]+\.[0-9]+)*$/])
  context "when #{host_os}," do
    describe Sys::Proc do
      context '.system_concern.to_s' do
        it do
          concern = {
            linux_gnu: 'Sys::Proc::Concern::System::LinuxGnu',
            freebsd:   'Sys::Proc::Concern::System::Freebsd'
          }.fetch(Sys::Proc.system)

          expect(subject.__send__(:system_concern).to_s).to eq(concern)
        end
      end

      Array.new(16).map { sham!(:progname).random.call }.each do |progname|
        context '.progname' do
          before(:each) { subject.progname = progname }

          it { expect(subject.progname).to eq(progname) }

          it { expect(subject.progname).to eq($PROGRAM_NAME) }

          next unless host_match?(/^linux-gnu$/)

          it { expect(subject.progname).to be_running.with_pid(subject.pid) }
        end
      end
    end
  end
end
