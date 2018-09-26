require_relative  'application_spec_helper'

RSpec.describe GeoCoder do

  describe '#call' do
    subject { GeoCoder.new }
    before { allow(subject).to receive(:call).with(nil) }
    it { should respond_to(:call) }

    it 'should process request' do
      geocoder = GeoCoder.new
      expect(geocoder).to receive(:process_request)
      geocoder.call(nil)
    end
  end

  describe '#process_request' do

  end
end
