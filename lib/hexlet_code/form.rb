# frozen_string_literal: true

# The root module
module HexletCode
  # form validation
  class Form
    attr_reader :inputs

    def initialize(user, url)
      @user = user
      @inputs = []
      @inputs << {
        tag_name: 'form',
        action: url.nil? ? '#' : url,
        method: 'post'
      }
    end

    def input(input_name, **kwargs)
      @inputs << {
        tag_name: 'input',
        name: input_name,
        value: get_input_value(input_name),
        type: 'text',
        **kwargs
      }
    end

    def submit(value = 'Save')
      raise 'The argument should be a string' unless value.instance_of? String

      @inputs << {
        tag_name: 'input', value: value, type: 'submit', name: 'commit'
      }
    end

    private

    def get_input_value(input_name)
      @user.methods.include?(input_name) ? @user.send(input_name) : ''
    end
  end
end
