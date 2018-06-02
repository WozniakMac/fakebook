require 'spec_helper'
require 'faraday'
require 'api/coolpay/connection'

describe Api::Coolpay::Connection do
  subject(:connection) { described_class }

  describe '.api' do
    it 'generate faraday connection' do
      expect(connection.api).to be_a Faraday::Connection
    end

    it 'containses url' do
      expect(connection.api.url_prefix.to_s).to eq(Api::Coolpay::Connection::BASE_URL)
    end

    context 'without token' do
      it 'containses headers' do
        expect(connection.api.headers).to eq(
          'Content-Type' => 'application/json',
          'User-Agent' => 'Faraday v0.12.2'
        )
      end
    end

    context 'with token' do
      let(:token) { 'auth_token' }

      it 'containses headers' do
        expect(connection.api(token).headers).to eq(
          'Content-Type' => 'application/json',
          'Authorization' => 'auth_token',
          'User-Agent' => 'Faraday v0.12.2'
        )
      end
    end
  end

  describe '.get' do
    let(:query) { { 'a' => 'b' } }
    let(:path) { '/path' }
    let(:token) { 'token' }
    let(:body) { { 'body' => 'body' } }
    let(:response) { instance_double('Faraday::Response', body: body.to_json, status: 200) }
    let(:api) { instance_double('Faraday::Connection') }

    before do
      allow(described_class).to receive(:api).with(token).and_return(api)
      allow(api).to receive(:get).with(path, query).and_return(response)
    end

    it 'make get request' do
      expect(connection.get(path, query, token)).to eq([body, 200])
    end
  end

  describe '.post' do
    let(:query_body) { { 'a' => 'b' } }
    let(:path) { '/path' }
    let(:token) { 'token' }
    let(:body) { { 'body' => 'body' } }
    let(:response) { instance_double('Faraday::Response', body: body.to_json, status: 200) }
    let(:api) { instance_double('Faraday::Connection') }

    before do
      allow(described_class).to receive(:api).with(token).and_return(api)
      allow(api).to receive(:post).and_return(response)
    end

    it 'make post request' do
      expect(connection.post(path, query_body, token)).to eq([body, 200])
    end
  end
end
