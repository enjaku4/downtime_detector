shared_examples_for 'asynchronous mailer' do
  let(:delayed_mailer) { class_double(described_class) }
  let(:args) { double }

  before { allow(described_class).to receive(:delay).with(queue: 'mailers').and_return(delayed_mailer) }

  it 'delivers the email' do
    expect(delayed_mailer).to receive(:deliver).with(args)
    described_class.deliver_async(args)
  end
end