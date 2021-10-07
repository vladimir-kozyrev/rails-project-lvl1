# frozen_string_literal: true

# I cannot autoload :Inputs
# LoadError: cannot load such file -- hexlet_code/inputs
require_relative 'hexlet_code/inputs/base'
require_relative 'hexlet_code/inputs/string_input'
require_relative 'hexlet_code/inputs/text_area'
require_relative 'hexlet_code/inputs/select'

# The root module
module HexletCode
  autoload :VERSION, 'hexlet_code/version'
  autoload :Tag, 'hexlet_code/tag'
  autoload :InputRenderer, 'hexlet_code/input_renderer'
  autoload :Form, 'hexlet_code/form'

  def self.form_for(user, url: nil)
    form = Form.new(user, url)
    yield form if block_given?
    form.finalize_form
  end
end
