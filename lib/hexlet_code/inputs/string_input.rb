# frozen_string_literal: true

module HexletCode
  module Inputs
    # Creates string inputs
    class StringInput < Base
      def initialize(text = nil, **kwargs)
        super(kwargs[:tag_name], text, **kwargs)
      end
    end
  end
end
