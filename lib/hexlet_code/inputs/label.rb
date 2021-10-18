# frozen_string_literal: true

module HexletCode
  module Inputs
    # Creates string inputs
    class Label < Base
      def initialize(input_name)
        super('label', input_name.to_s.capitalize, for: input_name)
      end
    end
  end
end
