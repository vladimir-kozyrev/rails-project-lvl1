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
      rendered_inputs.append submit_tag
      form_tag_with_inputs(rendered_inputs.join)
    end

    private

    def submit_tag
      tag = Tag.build('input', **@form.submit_attributes)
      "#{tag}\n"
    end

    def form_tag_with_inputs(inputs)
      rendered_form = Tag.build(
        'form',
        action: @form.url.nil? ? '#' : @form.url,
        method: 'post'
      ) { "\n#{inputs}" }
      "#{rendered_form}\n"
    end
  end
end
