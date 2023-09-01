# frozen_string_literal: true

class ZipCompressorService
  def self.call(...)
    new(...).compress
  end

  def initialize(file_streams = [])
    @file_streams = file_streams
  end

  def compress
    files_validator

    response_data(binary_data: zip_binary_data)
  end

  private

  attr_reader :file_streams

  def filename
    timestamp = Time.zone.now.strftime('%Y%m%d_%H%M%S')

    @filename ||= "#{timestamp}.zip"
  end

  def zip_binary_data
    zip_string = zip_maker
    zip_string.rewind
    zip_string.sysread
  end

  def zip_maker
    Zip::OutputStream.write_buffer do |stream|
      file_streams.each do |file_stream|
        stream.put_next_entry(file_stream[:filename])
        stream.write(file_stream[:stream].read)
      end
    end
  end

  def files_validator
    raise Services::ZipCompressor::MissingArgsError if file_streams.blank?

    return if file_streams_invalid.empty?

    raise Services::ZipCompressor::MissingFilesError, file_streams_invalid.pluck(:filename)
  end

  def file_streams_invalid
    @file_streams_invalid ||= file_streams.each_with_object([]) do |file_stream, items|
      items << file_stream unless file_stream[:stream].instance_of?(StringIO)
    end
  end

  def response_data(binary_data:)
    {
      binary_data:,
      filename:
    }
  end

  def save_zip_file
    File.binwrite("public/generated_files/#{filename}", zip_maker.string)
  end
end
