require 'spec_helper'
require 'api/coolpay/connection'
require 'api/coolpay/models/recipient'

describe Api::Coolpay::Models::Recipient do
  subject(:recipient) { described_class }

  let(:recipient_params) { { 'id' => 'id1', 'name' => 'name1' } }
  let(:token) { 'token' }

  describe '.new' do
    it 'creates recipient' do
      new_recipient = recipient.new(token, recipient_params)

      expect(new_recipient).to be_an_instance_of(described_class)
      expect(new_recipient.id).to eq('id1')
      expect(new_recipient.name).to eq('name1')
    end
  end

  describe '#save' do
    let(:response) { [{ 'recipient' => { 'name' => 'name1' } }, 200] }

    it 'push data thru the api' do
      allow(Api::Coolpay::Connection).to receive(:post)
        .with('/api/recipients', { 'recipient' => { 'name' => 'name1' } }, token)
        .and_return(response)

      new_recipient = recipient.new(token, recipient_params)

      expect(new_recipient.save).to eq(response[0])
    end
  end

  describe '.all' do
    let(:response) { [{ 'recipients' => [recipient_params, recipient_params] }, 200] }

    it 'get all recipients from api' do
      allow(Api::Coolpay::Connection).to receive(:get)
        .with('/api/recipients', {}, token)
        .and_return(response)

      recipients = described_class.all(token)
      expect(recipients.length).to eq(2)
    end
  end
end
