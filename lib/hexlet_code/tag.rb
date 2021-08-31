# frozen_string_literal: true

module HexletCode
  # A module that generates HTML tags
  module Tag
    def self.build(tag_name, **kwargs)
      raise "You must provide a tag name" if tag_name.nil?

      result = "<#{tag_name}"
      tag_args = kwargs.map { |key, value| "#{key}=\"#{value}\"" }
      result += format(" %s", tag_args.join(" ")) unless tag_args.empty?
      result += ">"
      result += yield + "</#{tag_name}>" if block_given?
      result
    end
  end
end
