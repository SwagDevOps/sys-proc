# frozen_string_literal: true

describe Sys::Proc do
  describe 'class methods' do
    methods = [:version_info, :instance, 'VERSION']

    methods.each do |method|
      it { expect(described_class).to respond_to(method) }
    end
  end

  describe 'instance methods' do
    methods = [:pid, :name, 'name=']

    methods.each do |method|
      it { expect(described_class).to respond_to(method) }
    end
  end
end
