require 'rails_helper'

RSpec.describe 'Data API', type: :request do
  let!(:datum) { create(:datum) }
  let(:id) { datum.id }

  describe 'GET /data/:id' do
    before { get "/data/#{id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json['ip']).to eq(datum.ip)
        expect(json['latitude']).to eq(datum.latitude)
        expect(json['longitude']).to eq(datum.longitude)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:id) { 999 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Datum with 'id'=#{id}/)
      end
    end
  end

  describe 'POST /data' do
    let(:ip) { '134.201.250.155' }

    context 'when the request is valid' do
      before { post '/data', params: { ip: ip }}

      it 'creates a datum' do
        json = JSON.parse(response.body)
        expect(json['ip']).to eq(ip)
        expect(json['latitude']).to_not eq(nil)
        expect(json['longitude']).to_not eq(nil)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/data', params: { ip: "eeee" } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Latitude can't be blank, Longitude can't be blank/)
      end
    end

    context 'when the ip parameter is missing' do
      before { post '/data', params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a parameter missing message' do
        expect(response.body).to match(/param is missing or the value is empty: ip/)
      end
    end
    context 'when the remote api is unavailable' do
      before { post '/data', params: {ip: "timeout"} }
      it 'returns status code 408' do
        expect(response).to have_http_status(408)
      end

      it 'returns execution expired error' do
        stub_request(:get, /api.ipstack.com/).to_timeout
        expect(response.body).to match(/execution expired/)
      end
    end
  end

  describe 'DELETE /data/:id' do
    before { delete "/data/#{id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
