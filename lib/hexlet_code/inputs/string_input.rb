# frozen_string_literal: true

module HexletCode
  module Inputs
    # Creates string inputs
    class StringInput < Base
      def initialize(content = nil, **kwargs)
        super('input', content, **kwargs)
      end
    end
  end
end
