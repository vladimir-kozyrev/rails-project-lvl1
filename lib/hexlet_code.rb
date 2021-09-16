# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/tag'
require_relative 'hexlet_code/inputs/base'
require_relative 'hexlet_code/inputs/string_input'
require_relative 'hexlet_code/inputs/text_area'
require_relative 'hexlet_code/form_renderer'
require_relative 'hexlet_code/form'

# The root module
module HexletCode
  def self.form_for(user, url: nil)
    form = Form.new(user, url)
    yield form if block_given?
    form.render
  end
end
