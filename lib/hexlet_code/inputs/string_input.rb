# frozen_string_literal: true

module HexletCode
  module Inputs
    # Creates string inputs
    class StringInput < Base
      def initialize(tag_name, text: nil, **kwargs)
        @tag_name = tag_name
        @text = text
        @kwargs = kwargs
      end
    end
  end
end
