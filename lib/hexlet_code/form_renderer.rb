# frozen_string_literal: true

# The root module
module HexletCode
  # Renders a form
  class FormRenderer
    def initialize(form, form_url)
      @form = form
      @rendered_form = HexletCode::Inputs::StringInput.new(
        'form',
        action: form_url.nil? ? '#' : form_url,
        method: 'post'
      ).to_s
    end

    def render
      @form.each do |input|
        @rendered_form += label_for_input(input[:input_name]) unless input[:type] == 'submit'
        @rendered_form += input_to_html(input)
      end
      @rendered_form += "\n</form>"
    end

    private

    def label_for_input(input_name)
      label = HexletCode::Inputs::StringInput.new(
        'label',
        input_name.to_s.capitalize,
        for: input_name
      )
      "\n#{label}"
    end

    def input_to_html(input)
      input_name = input[:input_name]
      input_value = input[:input_value]
      case input[:as]
      when nil
        type = input[:type].nil? ? 'text' : input[:type]
        name = input[:name].nil? ? input_name : input[:name]
        string_input(type, input_value, name, input[:class])
      when :text
        textarea_input(input_value, input[:cols], input[:rows], input_name, input[:class])
      end
    end

    def string_input(type, value, name, klass)
      input = HexletCode::Inputs::StringInput.new(
        'input',
        type: type,
        value: value,
        name: name,
        class: klass
      )
      "\n#{input}"
    end

    def textarea_input(value, cols, rows, name, klass)
      input = HexletCode::Inputs::TextArea.new(
        value,
        cols: cols,
        rows: rows,
        name: name,
        class: klass
      )
      "\n#{input}"
    end
  end
end
