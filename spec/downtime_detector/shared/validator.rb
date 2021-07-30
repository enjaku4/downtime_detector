shared_examples_for 'valid validator' do |data|
  it 'is valid' do
    expect(described_class.new(data).validate.success?).to be true
  end
end

shared_examples_for 'invalid validator' do |data|
  subject { described_class.new(data).validate }

  let(:errors) { data.delete(:errors) }

  it 'is invalid' do
    expect(subject.success?).to be false
  end

  it 'has errors' do
    errors.each do |key, value|
      expect(subject.errors[key]).to contain_exactly(value)
    end
  end
end
