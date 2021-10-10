# frozen_string_literal: true

# The root module
module HexletCode
  autoload :VERSION, 'hexlet_code/version.rb'
  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :FormRenderer, 'hexlet_code/form_renderer.rb'
  autoload :Form, 'hexlet_code/form.rb'
  autoload :Inputs, 'hexlet_code/inputs.rb'

  def self.form_for(user, url: nil)
    form = Form.new(user, url)
    yield form if block_given?
    FormRenderer.new(form).render
  end
end
