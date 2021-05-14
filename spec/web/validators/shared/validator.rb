shared_examples_for 'valid validator' do |data|
  it 'is valid' do
    expect(described_class.new(data).validate.success?).to be true
  end
end

shared_examples_for 'invalid validator' do |data, attribute, message|
  subject { described_class.new(data).validate }

  context "when #{data}" do
    it 'is invalid' do
      expect(subject.success?).to be false
    end

    it "has \'#{message}\' error" do
      expect(subject.errors[attribute]).to eq([message])
    end
  end
end
