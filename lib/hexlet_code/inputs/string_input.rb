# frozen_string_literal: true

module HexletCode
  module Inputs
    # Creates string inputs
    class StringInput < Base
      def initialize(content = nil, **attributes)
        super('input', content, **attributes)
      end
    end
  end
end
