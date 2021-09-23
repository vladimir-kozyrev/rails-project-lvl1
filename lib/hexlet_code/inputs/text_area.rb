# frozen_string_literal: true

module HexletCode
  module Inputs
    # Creates a <textarea> tag
    class TextArea < HexletCode::Inputs::Base
      def initialize(text, **kwargs)
        super('textarea', text, **kwargs)
      end
    end
  end
end
