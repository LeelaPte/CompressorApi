# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FilesController do
  describe 'POST /api/files/generate' do
    subject { post api_v1_files_generate_path }

    context 'when zip file is created' do
      let(:timestamp) { Time.zone.now.strftime('%Y%m%d_%H%M%S') }
      let(:file_name) { "#{timestamp}.zip" }

      it_behaves_like 'a successful request'

      it 'returns a zip headers' do
        headers = "attachment; filename=\"#{file_name}\"" \
                  ";\sfilename*=UTF-8''#{file_name}"

        subject

        expect(response.headers['Content-Disposition']).to match(headers)
      end
    end

    context 'when bad request is raised' do
      before do
        allow(FileManagerService).to receive(:call).and_raise(StandardError)
      end

      it_behaves_like 'a bad request'
    end
  end
end
