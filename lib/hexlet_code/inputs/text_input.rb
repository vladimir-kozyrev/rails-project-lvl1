# frozen_string_literal: true

module HexletCode
  module Inputs
    # Creates a <textarea> tag
    class TextInput < HexletCode::Inputs::Base
      def initialize(**attributes)
        super('textarea', attributes[:value], **attributes)
      end
    end
  end
end
