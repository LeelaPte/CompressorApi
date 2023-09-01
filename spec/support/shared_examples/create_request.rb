# frozen_string_literal: true

shared_examples 'a record created' do
  it 'returns http status created' do
    subject

    expect(response).to have_http_status(:created)
  end
end
