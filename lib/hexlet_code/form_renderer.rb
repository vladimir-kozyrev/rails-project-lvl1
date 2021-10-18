# frozen_string_literal: true

module HexletCode
  # takes a HexletCode::Form and renders it into HTML
  class FormRenderer
    def initialize(form)
      @form = form
    end

    def render
      rendered_inputs = @form.inputs.map do |input|
        InputRenderer.new(input).render
      end

      rendered_form = Tag.build(
        'form',
        action: @form.url.nil? ? '#' : @form.url,
        method: 'post'
      ) { "\n#{rendered_inputs.join}" }

      "#{rendered_form}\n"
    end
  end
end
