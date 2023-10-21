# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BuilderService do
  describe '.call' do
    subject { described_class.call(file_structure) }

    context 'when returns the correct data' do
      let(:file_structure) do
        {
          filename: 'File1.xlsx',
          headers: %i[head1 head2 head3 head4],
          rows: [
            { head1: 'value1', head2: 'value2', head3: 'value3', head4: 'value4' }
          ]
        }
      end

      it 'returns the correct data structure' do
        expect(subject.keys).to match(%i[filename stream])
      end
    end

    context 'when a row contains a nil value' do
      let(:file_structure) do
        {
          filename: 'pano_file1.xlsx',
          headers: %w[A B C D],
          rows: [
            { 'A' => 1, 'B' => nil, 'C' => nil, 'D' => 2 },
            { 'A' => 1, 'B' => nil, 'C' => false, 'D' => 2 }
          ]
        }
      end
      let(:expected_row) { { head1: 1, head2: nil, head3: nil, head4: 2 } }
      let(:tmp_file) { Roo::Spreadsheet.open(subject[:stream], extension: :xlsx) }
      let(:tmp_file_rows) { tmp_file.each_with_pagename.to_a.flatten.last }

      it 'returns the correct data structure' do
        expect(subject.keys).to match(%i[filename stream])
      end

      it 'returns the expected file with correct format' do
        expect(tmp_file_rows.row(1)).to eq(file_structure[:headers])
        expect(tmp_file_rows.row(2)).to eq(expected_row.values)
        expect(tmp_file_rows.row(3)).to eq(expected_row.values)
      end
    end

    context 'when file_structure param is blank' do
      let(:file_structure) { {} }

      it 'raises an error' do
        expect { subject }.to raise_error(Services::Builder::MissingArgsError)
      end
    end

    context 'when filename is not provided' do
      let(:file_structure) do
        {
          headers: %i[head1 head2 head3 head4],
          rows: [
            { head1: 'value1', head2: 'value2', head3: 'value3', head4: 'value4' }
          ]
        }
      end

      it 'raises an error' do
        expect { subject }.to raise_error(Services::Builder::MissingFilenameError)
      end
    end

    context 'when headers are not provided' do
      let(:file_structure) do
        {
          filename: 'File1.xlsx',
          rows: [
            { head1: 'value1', head2: 'value2', head3: 'value3', head4: 'value4' }
          ]
        }
      end

      it 'raises an error' do
        expect { subject }.to raise_error(Services::Builder::MissingHeadersError)
      end
    end

    context 'when rows are not provided' do
      let(:file_structure) do
        {
          filename: 'File1.xlsx',
          headers: %i[head1 head2 head3 head4]
        }
      end

      it 'raises an error' do
        expect { subject }.to raise_error(Services::Builder::MissingRowsError)
      end
    end
  end
end
