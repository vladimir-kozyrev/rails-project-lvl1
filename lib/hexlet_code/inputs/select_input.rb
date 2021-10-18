# frozen_string_literal: true

module HexletCode
  module Inputs
    # Creates <select> inputs
    class SelectInput < Base
      def initialize(**kwargs)
        @options = kwargs[:collection]
        raise 'You must specify a collection for "select" input' if @options.nil? ||
                                                                    !@options.instance_of?(Array)

        @kwargs = kwargs
        super('select', generate_options, **kwargs)
      end

      private

      def generate_options
        select_options = @options.map do |option|
          option_tag = HexletCode::Inputs::StringInput.new(
            option, tag_name: 'option', value: option, class: @kwargs[:class]
          )
          "\n#{option_tag}"
        end
        "#{select_options.join}\n"
      end
    end
  end
end
