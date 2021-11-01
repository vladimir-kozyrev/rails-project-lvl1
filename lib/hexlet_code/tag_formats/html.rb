# frozen_string_literal: true

module HexletCode
  module TagFormats
    # a module that builds tags in HTML format
    module Html
      def self.build(tag_name, **attributes, &block)
        result = ["<#{tag_name}"]
        attributes.each do |key, value|
          result.append(" #{key}='#{value}'") unless value.nil? ||
                                                     (value.instance_of?(String) && value.empty?)
        end
        result.append('>')
        result.append("#{block.call}</#{tag_name}>") if block_given?
        result.join
      end
    end
  end
end
