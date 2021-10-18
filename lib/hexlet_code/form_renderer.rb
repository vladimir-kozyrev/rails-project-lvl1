# frozen_string_literal: true

module HexletCode
  # takes a HexletCode::Form and renders it into HTML
  class FormRenderer
    def initialize(form)
      @form = form
      @result = ''
    end

    def render
      @form.inputs.each do |input|
        @result += InputRenderer.new(input).render
      end
      "#{@result}</form>\n"
    end
  end
end
