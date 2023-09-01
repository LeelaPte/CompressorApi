# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ZipCompressorService do
  describe '.call' do
    subject { described_class.call(file_streams) }

    context 'when there is no file streams provided' do
      let(:file_streams) { [] }

      it 'raises an error' do
        expect { subject }.to raise_error(Services::ZipCompressor::MissingArgsError)
      end
    end

    context 'when file stream provided is not StringIO object' do
      let(:file_streams) do
        [
          {
            filename: 'File1.xlsx',
            stream: Object.new
          }
        ]
      end

      it 'raises an error' do
        expect { subject }.to raise_error(Services::ZipCompressor::MissingFilesError)
      end
    end

    context 'when file_stream provided is valid' do
      let(:file_streams) do
        [
          {
            filename: 'File1.xlsx',
            stream: StringIO.new
          }
        ]
      end

      it 'returns the correct data structure' do
        expect(subject.keys).to match(%i[binary_data filename])
      end
    end
  end
end
