module HexletCode
  module Inputs
    class TextArea < HexletCode::Inputs::Base
      def initialize(text, **kwargs)
        @tag_name = 'textarea'
        @text = text
        @kwargs = kwargs
      end
    end
  end
end
