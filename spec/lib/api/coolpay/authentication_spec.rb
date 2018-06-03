require 'spec_helper'
require 'api/coolpay/authentication'
require 'api/coolpay/connection'

describe Api::Coolpay::Authentication do
  subject(:authentication) { described_class }

  describe '.login' do
    let(:query_body) { { 'a' => 'b' } }
    let(:path) { '/path' }
    let(:body) { { 'body' => 'body' } }
    let(:response) { [body, 200] }
    let(:invalid_response) { [body, 404] }
    let(:api) { instance_double('Faraday::Connection') }
    let(:username) { 'username' }
    let(:apitoken) { 'apitoken' }

    context 'when successful login' do
      it 'returns body' do
        allow(Api::Coolpay::Connection).to receive(:api).and_return(api)
        allow(api).to receive(:post).and_return(response)

        expect(authentication.login(username, apitoken)).to eq(body)
      end
    end

    context 'when unsuccessful login' do
      it 'returns body' do
        allow(Api::Coolpay::Connection).to receive(:api).and_return(api)
        allow(api).to receive(:post).and_return(invalid_response)

        expect(authentication.login(username, apitoken)).to eq(
          'error' => 'Unsuccessful login'
        )
      end
    end
  end
end
