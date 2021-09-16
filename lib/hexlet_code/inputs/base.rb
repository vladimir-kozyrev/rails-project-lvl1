# frozen_string_literal: true

module HexletCode
  module Inputs
    # A parent of all inputs here
    class Base
      def initialize(tag_name, text = nil, **kwargs)
        @tag_name = tag_name
        @text = text
        @kwargs = kwargs
      end

      def to_s
        if @text.nil?
          HexletCode::Tag.build(@tag_name, **@kwargs)
        else
          HexletCode::Tag.build(@tag_name, **@kwargs) { @text }
        end
      end
    end
  end
end
