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
      when :select
        select_input(input[:collection], **input)
      end
    end

    def string_input(tag_name, **kwargs)
      allowed_kwargs = %i[type value name class action method]
      input = HexletCode::Inputs::StringInput.new(
        tag_name,
        **input_kwargs(kwargs, allowed_kwargs)
      )
      @add_newline_for_input ? "\n#{input}" : input.to_s
    end

    def textarea_input(value, **kwargs)
      allowed_kwargs = %i[cols rows name class]
      input = HexletCode::Inputs::TextArea.new(
        value,
        **input_kwargs(kwargs, allowed_kwargs)
      )
      @add_newline_for_input ? "\n#{input}" : input.to_s
    end

    def select_input(options, **kwargs)
      raise 'You must specify a collection for "select" input' if options.nil? ||
                                                                  !options.instance_of?(Array)

      allowed_kwargs = %i[name class]
      input = HexletCode::Inputs::Select.new(
        options,
        **input_kwargs(kwargs, allowed_kwargs)
      )
      @add_newline_for_input ? "\n#{input}" : input.to_s
    end

    def input_kwargs(kwargs, allowed_kwargs)
      kwargs.filter { |arg| allowed_kwargs.include? arg }
    end
  end
end
