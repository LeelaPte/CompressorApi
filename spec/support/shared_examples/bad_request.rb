# frozen_string_literal: true

shared_examples 'a bad request' do
  it 'returns http bad request' do
    subject

    expect(response).to have_http_status(:bad_request)
  end
end
