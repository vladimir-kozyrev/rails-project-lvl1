# frozen_string_literal: true

module HexletCode
  module Inputs
    # Creates <select> inputs
    class SelectInput < Base
      def initialize(**attributes)
        @options = attributes[:collection]
        raise 'You must specify a collection for "select" input' if @options.nil? ||
                                                                    !@options.instance_of?(Array)

        @attributes = attributes
        super('select', generate_options, **attributes)
      end

      private

      def generate_options
        select_options = @options.map do |option|
          option_tag = HexletCode::Tag.build(
            'option', value: option, class: @attributes[:class]
          ) { option }
          "\n#{option_tag}"
        end
        "#{select_options.join}\n"
      end
    end
  end
end
