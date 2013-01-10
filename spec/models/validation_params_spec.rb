require './app/models/validation_params'

describe ValidationParams do
  subject { ValidationParams.new('---\n:likes: 0\n:oracle: false\n') }

  describe "#to_hash" do
    it 'should load YAML' do
      YAML.should_receive(:load).with(subject)
      subject.to_hash
    end
  end
end
