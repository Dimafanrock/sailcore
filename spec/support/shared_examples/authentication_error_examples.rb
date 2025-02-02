RSpec.shared_examples 'an authentication error' do |status, error_message_key|
  it 'returns an error response with the correct status and message' do
    make_request

    expect(response).to have_http_status(status)

    json_response = response.parsed_body
    expect(json_response['errors']).to include(I18n.t(error_message_key))
  end
end
