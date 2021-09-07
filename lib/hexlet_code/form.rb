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
      @form += HexletCode::Label.new(input_name).generate
      value = get_input_value(input_name)

      case kwargs[:as]
      when nil
        @form += HexletCode::Input.new(input_name, type: 'text', **kwargs).generate(value)
      when :text
        @form += HexletCode::TextArea.new(input_name, **kwargs).generate(value)
      when :select
        @form += HexletCode::Select.new(input_name, **kwargs).generate
      end
    end

    def submit(value = 'Save')
      raise 'The argument should be a string' unless value.instance_of? String

      @form += HexletCode::Input.new('input', type: 'submit', value: value, name: 'commit').generate(value)
    end

    def finalize_form
      @form += "\n</form>"
    end

    private

    def form_beginning
      action = @url.nil? ? '#' : @url
      HexletCode::FormTag.new(nil).generate(action)
    end

    def get_input_value(input_name)
      @user.methods.include?(input_name) ? @user.send(input_name) : ''
    end
  end
end
