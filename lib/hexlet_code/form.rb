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

    # def input(input_name, **kwargs)
    #   label = HexletCode::Inputs::StringInput.new(
    #     'label',
    #     text: input_name.to_s.capitalize,
    #     for: input_name
    #   ).to_s
    #   @form += "\n#{label}"
    #   value = get_input_value(input_name)
    # end
    # def submit(value = 'Save')
    #   raise 'The argument should be a string' unless value.instance_of? String

    #   tag = HexletCode::Inputs::StringInput.new('input', type: 'submit', value: value, name: 'commit')
    #   @form += "\n#{tag}"
    # end

    private

    def get_input_value(input_name)
      @user.methods.include?(input_name) ? @user.send(input_name) : ''
    end
  end
end
