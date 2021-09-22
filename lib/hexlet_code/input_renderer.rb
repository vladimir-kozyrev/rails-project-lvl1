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
      case input[:as]
      when nil
        string_input(input[:tag_name], **input)
      when :text
        textarea_input(input[:value], **input)
      end
    end

    def string_input(tag_name, **kwargs)
      allowed_input_args = %i[type value name class action method]
      input_kwargs = kwargs.filter { |arg| allowed_input_args.include? arg }
      input = HexletCode::Inputs::StringInput.new(
        tag_name,
        **input_kwargs
      )
      @add_newline_for_input ? "\n#{input}" : input.to_s
    end

    def textarea_input(value, **kwargs)
      allowed_input_args = %i[cols rows name class]
      input_kwargs = kwargs.filter { |arg| allowed_input_args.include? arg }
      input = HexletCode::Inputs::TextArea.new(
        value,
        **input_kwargs
      )
      @add_newline_for_input ? "\n#{input}" : input.to_s
    end
  end
end
