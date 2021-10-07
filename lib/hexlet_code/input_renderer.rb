# frozen_string_literal: true

# The root module
module HexletCode
  # Renders a form
  class InputRenderer
    def initialize(input, add_newline_for_input: true, add_newline_for_label: true)
      @input = input
      @add_newline_for_input = add_newline_for_input
      @add_newline_for_label = add_newline_for_label
    end

    def render
      result = ''
      result += label_for_input(@input[:name]) unless @input[:type] == 'submit' ||
                                                      @input[:tag_name] == 'form'
      result + input_to_html(@input)
    end

    private

    def label_for_input(input_name)
      label = HexletCode::Inputs::StringInput.new(
        'label',
        input_name.to_s.capitalize,
        for: input_name
      )
      @add_newline_for_label ? "\n#{label}" : label.to_s
    end

    def input_to_html(input)
      result = case input[:as]
               when nil
                 HexletCode::Inputs::StringInput.new(input[:tag_name], **input).to_s
               when :text
                 HexletCode::Inputs::TextArea.new(input[:value], **input)
               when :select
                 HexletCode::Inputs::Select.new(input[:collection], **input)
               end
      @add_newline_for_input ? "\n#{result}" : result.to_s
    end
  end
end
