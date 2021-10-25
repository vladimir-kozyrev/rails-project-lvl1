# frozen_string_literal: true

module HexletCode
  module TagFormats
    # a module that builds tags in HTML format
    module Html
      def self.build(tag_name, **kwargs, &block)
        result = kwargs.inject("<#{tag_name}") do |memo, (k, v)|
          if v.nil? || (v.instance_of?(String) && v.empty?)
            memo
          else
            memo + " #{k}='#{v}'"
          end
        end
        result += '>'
        result += block.call + "</#{tag_name}>" if block_given?
        result
      end
    end
  end
end
