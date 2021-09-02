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
      @form += "\n<label for=\"#{field}\">#{field.capitalize}</label>"
      case kwargs[:as]
      when nil
        generate_input(field, klass: kwargs[:class])
      when :text
        generate_textarea(field, rows: kwargs[:rows], cols: kwargs[:cols], klass: kwargs[:class])
      when :select
        generate_select(field, collection: kwargs[:collection], klass: kwargs[:class])
      end
    end

    def submit(value = "Save")
      raise "The argument should be a string" unless value.instance_of? String

      @form += "\n<input type=\"submit\" value=\"#{value}\" name=\"commit\">"
    end

    def finalize_form
      @form += "\n</form>"
    end

    private

    def form_beginning
      action = @url.nil? ? "#" : @url
      "<form action=\"#{action}\" method=\"post\">"
    end

    def generate_input(field, klass: nil)
      value = get_field_value(field)
      @form += "\n<input"
      @form += html_attribute("type", "text")
      @form += html_attribute("value", value)
      @form += html_attribute("name", field)
      @form += html_attribute("class", klass)
      @form += ">"
    end

    def generate_textarea(field, rows: 20, cols: 40, klass: nil)
      value = get_field_value(field)
      @form += "\n<textarea"
      @form += html_attribute("cols", cols)
      @form += html_attribute("rows", rows)
      @form += html_attribute("name", field)
      @form += html_attribute("class", klass)
      @form += ">#{value}</textarea>"
    end

    def generate_select(field, collection: nil, klass: nil)
      raise "You must specify a collection for 'select' input" if collection.nil? ||
                                                                  !collection.instance_of?(Array)

      value = get_field_value(field)
      @form += collection.inject("\n<select name=\"gender\">") do |memo, gender|
        memo += "\n<option value=\"#{gender}\""
        memo += " selected" if value == gender
        memo + ">#{gender}</option>"
      end
      @form += html_attribute("class", klass)
      @form += "\n</select>"
    end

    def html_attribute(attr_name, attr_value)
      return " #{attr_name}=\"#{attr_value}\"" if attr_value.instance_of? Integer

      attr_value.nil? || attr_value.empty? ? "" : " #{attr_name}=\"#{attr_value}\""
    end

    def get_field_value(field)
      @user.methods.include?(field) ? @user.send(field) : ""
    end
  end
end
