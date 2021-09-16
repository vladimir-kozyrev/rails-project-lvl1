# frozen_string_literal: true

module HexletCode
  module Inputs
    # Creates a <textarea> tag
    class TextArea < HexletCode::Inputs::Base
      def initialize(text, **kwargs)
        @tag_name = 'textarea'
        @text = text
        @kwargs = kwargs
      end
    end
  end
end
