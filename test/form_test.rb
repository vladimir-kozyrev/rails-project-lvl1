# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def setup
    user_class = Struct.new(:name, :job, :gender, :foo, :bar, keyword_init: true)
    @user = user_class.new name: 'rob', job: 'hexlet', gender: 'm'
  end

  def test_form_for_with_default_values
    expected_result = File.open("#{__dir__}/fixtures/form_for_default.html")
    actual_result = HexletCode.form_for(@user) do |f|
      f.input :name
      f.input :job, as: :text, rows: 40, cols: 30
      f.input :gender, as: :select, collection: %w[m f]
      f.submit
    end
    assert_equal expected_result.read, actual_result
  end

  def test_form_for_with_custom_url_and_submit
    expected_result = File.open("#{__dir__}/fixtures/form_for_custom.html")
    actual_result = HexletCode.form_for(@user, url: '/test') do |f|
      f.input :name
      f.input :job, as: :text, rows: 40, cols: 30
      f.input :gender, as: :select, collection: %w[m f]
      f.submit 'Do it'
    end
    assert_equal expected_result.read, actual_result
  end
end
