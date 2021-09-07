# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/tag'
require_relative 'hexlet_code/form'
require_relative 'hexlet_code/input'

# HW #1
module HexletCode
  def self.form_for(user, url: nil)
    form = Form.new(user, url)
    yield form if block_given?
    form.finalize_form
  end
end
