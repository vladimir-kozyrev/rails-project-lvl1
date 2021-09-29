# frozen_string_literal: true

# The root module
module HexletCode
  # form validation
  class Form
    def initialize(user, url)
      @user = user
      @form = HexletCode::InputRenderer.new(
        {
          tag_name: 'form',
          action: url.nil? ? '#' : url,
          method: 'post'
        },
        add_newline_for_input: false
      ).render
    end

    def input(input_name, **kwargs)
      @form += HexletCode::InputRenderer.new(
        {
          tag_name: 'input',
          name: input_name,
          value: get_input_value(input_name),
          type: 'text',
          **kwargs
        }
      ).render
    end

    def submit(value = 'Save')
      raise 'The argument should be a string' unless value.instance_of? String

      @form += HexletCode::InputRenderer.new(
        {
          tag_name: 'input', value: value, type: 'submit', name: 'commit'
        }
      ).render
    end

    def finalize_form
      @form += "\n</form>\n"
    end

    private

    def get_input_value(input_name)
      @user.methods.include?(input_name) ? @user.send(input_name) : ''
    end
  end
end
