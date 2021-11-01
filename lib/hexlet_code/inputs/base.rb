# frozen_string_literal: true

module HexletCode
  module Inputs
    # A parent of all inputs here
    class Base
      def initialize(tag_name, content = nil, **attributes)
        @tag_name = tag_name
        @content = content
        @attributes = attributes
      end

      def to_s
        if @content.nil?
          HexletCode::Tag.build(@tag_name, **@attributes)
        else
          HexletCode::Tag.build(@tag_name, **@attributes) { @content }
        end
      end
    end
  end
end
