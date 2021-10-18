# frozen_string_literal: true

module HexletCode
  module Inputs
    # Creates a <textarea> tag
    class TextInput < HexletCode::Inputs::Base
      def initialize(**kwargs)
        super('textarea', kwargs[:value], **kwargs)
      end
    end
  end
end
