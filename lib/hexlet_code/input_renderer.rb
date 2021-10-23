# frozen_string_literal: true

module HexletCode
  # Renders an input
  class InputRenderer
    def initialize(input)
      @input = input
    end

    def render
      result = ''
      result += label_for_input(@input[:name]) unless @input[:type] == 'submit'
      result + input_to_html(@input)
    end

    private

    def label_for_input(input_name)
      label = Inputs::Label.new(input_name)
      "#{label}\n"
    end

    def input_to_html(input)
      type = input[:as].nil? ? 'String' : input[:as].to_s.capitalize
      input = Object.const_get("HexletCode::Inputs::#{type}Input").new(**input)
      "#{input}\n"
    end
  end
end
