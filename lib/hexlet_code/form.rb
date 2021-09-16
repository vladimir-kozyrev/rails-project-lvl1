# frozen_string_literal: true

# The root module
module HexletCode
  # form validation
  class Form
    def initialize(user, url)
      @user = user
      @url = url
      @form = []
    end

    def input(input_name, **kwargs)
      @form.append(
        {
          input_name: input_name,
          input_value: get_input_value(input_name),
          **kwargs
        }
      )
    end

    def submit(value = 'Save')
      raise 'The argument should be a string' unless value.instance_of? String

      @form.append(
        {
          input_name: 'input', input_value: value, type: 'submit', name: 'commit'
        }
      )
    end

    def render
      renderer = HexletCode::FormRenderer.new(@form, @url)
      renderer.render
    end

    private

    def get_input_value(input_name)
      @user.methods.include?(input_name) ? @user.send(input_name) : ''
    end
  end
end
