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

    # Renders an input
    class InputRenderer
      def initialize(input)
        @input = input
      end

      def render
        result = ''
        result += label_for_input(@input[:name]) unless @input[:type] == 'submit' ||
                                                        @input[:tag_name] == 'form'
        result + input_to_html(@input)
      end

      private

      def label_for_input(input_name)
        label = HexletCode::Inputs::StringInput.new(
          'label',
          input_name.to_s.capitalize,
          for: input_name
        )
        "#{label}\n"
      end

      def input_to_html(input)
        result = case input[:as]
                 when nil
                   Inputs::StringInput.new(input[:tag_name], **input)
                 when :text
                   Inputs::TextArea.new(input[:value], **input)
                 when :select
                   Inputs::Select.new(input[:collection], **input)
                 end
        "#{result}\n"
      end
    end
  end
end
