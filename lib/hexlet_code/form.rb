# frozen_string_literal: true

# The root module
module HexletCode
  # form validation
  class Form
    attr_reader :inputs, :url, :submit_attributes

    def initialize(user, url)
      @user = user
      @url = url
      @inputs = []
    end

    def input(input_name, **attributes)
      @inputs << {
        name: input_name,
        value: get_input_value(input_name),
        type: 'text',
        **attributes
      }
    end

    def submit(value = 'Save')
      raise 'The argument should be a string' unless value.instance_of? String

      @submit_attributes = {
        value: value, type: 'submit', name: 'commit'
      }
    end

    private

    def get_input_value(input_name)
      @user.send(input_name)
    end
  end
end
