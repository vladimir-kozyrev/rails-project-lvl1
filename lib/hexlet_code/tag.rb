# frozen_string_literal: true

module HexletCode
  # A module that generates HTML tags
  module Tag
    def self.build(tag_name, **kwargs, &block)
      raise 'You must provide a tag name' if tag_name.nil?

      begin
        format = HexletCode.format.capitalize
        tag_format = Object.const_get("HexletCode::TagFormats::#{format}")
      rescue NameError
        raise HexletCode::Exceptions::UnknownTagFormat, 'This format is not supported'
      end
      tag_format.build(tag_name, **kwargs, &block)
    end
  end
end
