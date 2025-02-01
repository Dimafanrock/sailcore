require 'rails_helper'

RSpec.describe 'Api::Concerns::ErrorHandler', type: :controller do
  controller(ApplicationController) do
    include Api::V1::Concerns::ErrorHandler

    def show
      raise ActiveRecord::RecordNotFound, "Couldn't find Resource with 'id'=9999"
    end
  end

  before do
    routes.draw { get 'test_not_found' => 'anonymous#show' }
  end

  it 'returns a 404 response with an error message' do
    get :show

    expect(response).to have_http_status(:not_found)

    json_response = response.parsed_body
    expect(json_response['errors']).to include("Couldn't find Resource with 'id'=9999")
  end
end
