# frozen_string_literal: true

class BuilderService
  DEFAULT_SHEET_NAME = 'Data'

  def self.call(file_structure = {})
    new(file_structure).generate
  end

  def initialize(file_structure = {})
    @file_structure = file_structure
    @headers = file_structure[:headers]
    @rows = file_structure[:rows]
    @filename = file_structure[:filename]
  end

  def generate
    file_structure_validator

    response_data
  end

  private

  attr_reader :file_structure, :headers, :rows, :filename

  def xlsx_file
    @xlsx_file ||= Axlsx::Package.new
  end

  def xlsx_maker
    xlsx_schema
    xlsx_file.use_shared_strings = true

    xlsx_file.to_stream
  end

  def xlsx_schema
    xlsx_file.workbook.add_worksheet(name: DEFAULT_SHEET_NAME) do |sheet|
      sheet.add_row(headers)
      rows.each do |row|
        sheet.add_row(row_distribution(row))
      end
    end
  end

  def row_distribution(row)
    headers.each_with_object([]) do |header, items|
      items << (row[header].presence || '')
    end
  end

  def file_structure_validator
    raise Services::Builder::MissingArgsError if file_structure.blank?
    raise Services::Builder::MissingFilenameError if filename.blank?
    raise Services::Builder::MissingHeadersError if headers.blank?
    raise Services::Builder::MissingRowsError if rows.blank?
  end

  def response_data
    {
      filename:,
      stream: xlsx_maker
    }
  end
end
