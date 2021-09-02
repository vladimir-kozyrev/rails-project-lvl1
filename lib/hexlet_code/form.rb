# frozen_string_literal: true

# HW #1
module HexletCode
  def self.form_for(user, url: nil)
    form = Form.new(user, url)
    yield form if block_given?
    form.finalize_form
  end

  # form validation
  class Form
    def initialize(user, url)
      @user = user
      @url = url
      @form = form_beginning
    end

    def input(field, **kwargs)
      tag = HexletCode::Tag.build('label', for: field) { field.to_s.capitalize }
      @form += "\n#{tag}"
      case kwargs[:as]
      when nil
        generate_input(field, klass: kwargs[:class])
      when :text
        generate_textarea(field, rows: kwargs[:rows], cols: kwargs[:cols], klass: kwargs[:class])
      when :select
        generate_select(field, collection: kwargs[:collection], klass: kwargs[:class])
      end
    end

    def submit(value = 'Save')
      raise 'The argument should be a string' unless value.instance_of? String

      tag = HexletCode::Tag.build('input', type: 'submit', value: value, name: 'commit')
      @form += "\n#{tag}"
    end

    def finalize_form
      @form += "\n</form>"
    end

    private

    def form_beginning
      action = @url.nil? ? '#' : @url
      HexletCode::Tag.build('form', action: action, method: 'post')
    end

    def generate_input(field, klass: nil)
      value = get_field_value(field)
      tag = HexletCode::Tag.build('input', type: 'text', value: value, name: field, class: klass)
      @form += "\n#{tag}"
    end

    def generate_textarea(field, rows: 20, cols: 40, klass: nil)
      value = get_field_value(field)
      tag = HexletCode::Tag.build(
        'textarea', cols: cols, rows: rows, name: field, class: klass
      ) { value }
      @form += "\n#{tag}"
    end

    def generate_select(field, collection: nil, klass: nil)
      raise 'You must specify a collection for "select" input' if collection.nil? ||
                                                                  !collection.instance_of?(Array)

      tag = HexletCode::Tag.build('select', name: field, class: klass) do
        nested_tags = collection.map do |gender|
          option_tag = HexletCode::Tag.build('option', value: gender, class: klass) { gender }
          "\n#{option_tag}"
        end
        "#{nested_tags.join}\n"
      end
      @form += "\n#{tag}"
    end

    def get_field_value(field)
      @user.methods.include?(field) ? @user.send(field) : ''
    end
  end
end
