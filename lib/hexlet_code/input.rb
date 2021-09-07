# frozen_string_literal: true

# HW #1
module HexletCode
  # A parent of all inputs here
  class BasicTag
    def initialize(input_name, **kwargs)
      @input_name = input_name
      @kwargs = kwargs
    end
  end

  # generates <form> tag
  class FormTag < BasicTag
    def generate(action)
      HexletCode::Tag.build('form', action: action, method: 'post')
    end
  end

  # generates <input> tag
  class Input < BasicTag
    def generate(value, add_newline: true)
      name = @kwargs[:name] || @input_name
      tag = HexletCode::Tag.build('input', type: @kwargs[:type], value: value, name: name, class: @kwargs[:class])
      add_newline ? "\n#{tag}" : tag
    end
  end

  # generates <textarea> tag
  class TextArea < BasicTag
    def generate(value, add_newline: true)
      tag = HexletCode::Tag.build(
        'textarea', cols: @kwargs[:cols], rows: @kwargs[:rows], name: @input_name, class: @kwargs[:class]
      ) { value }
      add_newline ? "\n#{tag}" : tag
    end
  end

  # generates <label> tag
  class Label < BasicTag
    def generate(add_newline: true)
      tag = HexletCode::Tag.build('label', for: @input_name) { @input_name.to_s.capitalize }
      add_newline ? "\n#{tag}" : tag
    end
  end

  # generates <select> tag
  class Select < BasicTag
    def generate(add_newline: true)
      collection = @kwargs[:collection]
      raise 'You must specify a collection for "select" input' if collection.nil? ||
                                                                  !collection.instance_of?(Array)

      tag = HexletCode::Tag.build('select', name: @input_name, class: @kwargs[:class]) do
        nested_tags = collection.map do |gender|
          option_tag = HexletCode::Tag.build('option', value: gender, class: @kwargs[:class]) { gender }
          "\n#{option_tag}"
        end
        "#{nested_tags.join}\n"
      end
      add_newline ? "\n#{tag}" : tag
    end
  end
end
