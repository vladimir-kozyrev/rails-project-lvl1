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
    attr_reader :form

    def initialize(user, url)
      @user = user
      @url = url
      @form = form_beginning
    end

    def input(field, **kwargs)
      case kwargs[:as]
      when nil
        generate_input(field)
      when :text
        generate_textarea(field)
      when :select
        generate_select(field, kwargs[:collection])
      end
    end

    def finalize_form
      @form += "\n</form>"
    end

    private

    def form_beginning
      action = @url.nil? ? "#" : @url
      form = "<form action=\"#{action}\" method=\"post\">"
      form = form.split("\n").map(&:strip)
      form.join("\n")
    end

    def generate_input(field)
      value = get_field_value(field)
      @form += "\n<input type=\"text\" value=\"#{value}\" name=\"#{field}\">"
    end

    def generate_textarea(field)
      value = get_field_value(field)
      @form += "\n<textarea cols=\"20\" rows=\"40\" name=\"#{field}\">#{value}</textarea>"
    end

    def generate_select(field, collection)
      raise "You must specify a collection for 'select' input" if collection.nil? ||
                                                                  !collection.instance_of?(Array)

      value = get_field_value(field)
      result = collection.inject("\n<select name=\"gender\">") do |memo, gender|
        memo += "\n<option value=\"#{gender}\""
        memo += " selected" if value == gender
        memo + ">#{gender}</option>"
      end
      @form += format("%<result>s%<end_of_field>s", result: result, end_of_field: "\n</select>")
    end

    def get_field_value(field)
      raise "The user does not have such method" unless @user.methods.include? field

      value = @user.send field
      raise "The field value for this user is not set" if value.nil? || value.empty?

      value
    end
  end
end
