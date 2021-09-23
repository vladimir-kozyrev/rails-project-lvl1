# frozen_string_literal: true

module HexletCode
  module Inputs
    # Creates <select> inputs
    class Select < Base
      def initialize(options, **kwargs)
        @options = options
        @kwargs = kwargs
        super('select', generate_options, **kwargs)
      end

      private

      def generate_options
        select_options = @options.map do |option|
          option_tag = HexletCode::Inputs::StringInput.new('option', option, value: option, class: @kwargs[:class])
          "\n#{option_tag}"
        end
        "#{select_options.join}\n"
      end
    end
  end
end
