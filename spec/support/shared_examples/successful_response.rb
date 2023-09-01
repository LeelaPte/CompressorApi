# frozen_string_literal: true

shared_examples 'a successful request' do
  it 'returns http success' do
    subject

    expect(response).to have_http_status(:success)
  end
end
