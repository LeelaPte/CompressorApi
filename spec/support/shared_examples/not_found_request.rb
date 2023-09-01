# frozen_string_literal: true

shared_examples 'a not found request' do
  it 'returns http not found' do
    subject

    expect(response).to have_http_status(:not_found)
  end
end
