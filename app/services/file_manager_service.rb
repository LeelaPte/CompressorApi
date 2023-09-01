# frozen_string_literal: true

class FileManagerService
  FILE_STRUCTURE_MOCK = [
    {
      filename: 'File2.xlsx',
      headers: %i[head1 head2 head3 head4],
      rows: [
        { head1: 'value1', head2: 'value2', head3: 'value3', head4: 'value3' }
      ]
    },
    {
      filename: 'File1.xlsx',
      headers: %i[head1 head2 head3 head4],
      rows: [
        { head1: 'value1', head2: 'value2', head3: 'value3', head4: 'value4' }
      ]
    }
  ].freeze

  def initialize(extra_data: {})
    @extra_data = extra_data
  end

  def self.call(...)
    new(...).perform
  end

  def perform
    exec_builder
    exec_zip_compressor
  end

  private

  attr_reader :extra_data

  def exec_builder
    @file_streams = FILE_STRUCTURE_MOCK.map do |file_structure|
      BuilderService.call(file_structure)
    end
  end

  def exec_zip_compressor
    ZipCompressorService.call(@file_streams)
  end
end
