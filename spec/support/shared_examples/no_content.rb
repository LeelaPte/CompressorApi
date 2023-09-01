# frozen_string_literal: true

shared_examples 'a no content response' do
  it 'returns no content status code' do
    subject

    expect(response).to have_http_status(:no_content)
  end
end
