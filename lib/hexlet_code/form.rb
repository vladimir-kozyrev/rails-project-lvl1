# frozen_string_literal: true

# HW #1
module HexletCode
  # form validation
  class Form
    def initialize(user, url)
      @user = user
      @url = url
      @form = form_beginning
    end

    def input(input_name, **kwargs)
      label = HexletCode::Inputs::StringInput.new(
        'label',
        text: input_name.to_s.capitalize,
        for: input_name
      ).to_s
      @form += "\n#{label}"
      value = get_input_value(input_name)

      case kwargs[:as]
      when nil
        tag = HexletCode::Inputs::StringInput.new(
          'input',
          type: 'text',
          value: value,
          name: input_name,
          **kwargs
        )
        @form += "\n#{tag}"
      when :text
        tag = HexletCode::Inputs::TextArea.new(
          value, cols: kwargs[:cols], rows: kwargs[:rows], name: input_name, class: kwargs[:class]
        ).to_s
        @form += "\n#{tag}"
      end
    end

    def submit(value = 'Save')
      raise 'The argument should be a string' unless value.instance_of? String

      tag = HexletCode::Inputs::StringInput.new('input', type: 'submit', value: value, name: 'commit')
      @form += "\n#{tag}"
    end

    def finalize_form
      @form += "\n</form>"
    end

    private

    def form_beginning
      action = @url.nil? ? '#' : @url
      HexletCode::Inputs::StringInput.new(
        'form',
        action: action,
        method: 'post'
      ).to_s
    end

    def get_input_value(input_name)
      @user.methods.include?(input_name) ? @user.send(input_name) : ''
    end
  end
end
