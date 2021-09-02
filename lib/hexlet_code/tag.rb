# frozen_string_literal: true

module HexletCode
  # A module that generates HTML tags
  module Tag
    def self.build(tag_name, **kwargs)
      raise 'You must provide a tag name' if tag_name.nil?

      result = kwargs.inject("<#{tag_name}") do |memo, (k, v)|
        if v.nil? || (v.instance_of?(String) && v.empty?)
          memo
        else
          memo + " #{k}='#{v}'"
        end
      end
      result += '>'
      result += yield + "</#{tag_name}>" if block_given?
      result
    end
  end
end
