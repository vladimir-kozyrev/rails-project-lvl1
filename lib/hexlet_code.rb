# frozen_string_literal: true

# The root module
module HexletCode
  autoload :VERSION, 'hexlet_code/version.rb'
  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :InputRenderer, 'hexlet_code/input_renderer.rb'
  autoload :FormRenderer, 'hexlet_code/form_renderer.rb'
  autoload :Form, 'hexlet_code/form.rb'
  autoload :Inputs, 'hexlet_code/inputs.rb'

  def self.form_for(user, url: nil)
    raise 'You must pass a block to the form_for method' unless block_given?

    form = Form.new(user, url)
    yield form if block_given?
    FormRenderer.new(form).render
  end
end
