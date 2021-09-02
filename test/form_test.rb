# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def setup
    user_class = Struct.new(:name, :job, :gender, :foo, :bar, keyword_init: true)
    @user = user_class.new name: 'rob', job: 'hexlet', gender: 'm'
  end

  def shorten(text)
    text.split("\n").map(&:strip).join("\n")
  end

  def test_form_for_without_url
    expected_result = <<-RESULT
      <form action='#' method='post'>
      </form>
    RESULT
    assert_equal shorten(expected_result), HexletCode.form_for(@user)
  end

  def test_form_for_with_url
    expected_result = <<-RESULT
      <form action='/users' method='post'>
      </form>
    RESULT
    assert_equal shorten(expected_result), HexletCode.form_for(@user, url: '/users')
  end

  def test_form_for_generates_form_with_input
    expected_result = <<-RESULT
      <form action='#' method='post'>
        <label for='name'>Name</label>
        <input type='text' value='rob' name='name' class='woo'>
      </form>
    RESULT
    assert_equal shorten(expected_result),
                 HexletCode.form_for(@user) { |f| f.input :name, class: 'woo' }
  end

  def test_form_for_raises_if_input_is_not_set
    expected_result = <<-RESULT
      <form action='#' method='post'>
        <label for='dog'>Dog</label>
        <input type='text' name='dog'>
      </form>
    RESULT
    assert_equal shorten(expected_result),
                 HexletCode.form_for(@user) { |f| f.input :dog }
  end

  def test_form_for_generates_form_with_text_input
    expected_result = <<-RESULT
      <form action='#' method='post'>
        <label for='job'>Job</label>
        <textarea cols='30' rows='40' name='job'>hexlet</textarea>
      </form>
    RESULT
    assert_equal shorten(expected_result),
                 HexletCode.form_for(@user) { |f| f.input :job, as: :text, rows: 40, cols: 30 }
  end

  def test_form_for_generates_form_with_select_input
    expected_result = <<-RESULT
      <form action='#' method='post'>
        <label for='gender'>Gender</label>
        <select name='gender'>
          <option value='m' selected>m</option>
          <option value='f'>f</option>
        </select>
      </form>
    RESULT
    assert_equal shorten(expected_result),
                 HexletCode.form_for(@user) { |f| f.input :gender, as: :select, collection: %w[m f] }
  end

  def test_form_for_generates_submit_with_default_value
    expected_result = <<-RESULT
      <form action='#' method='post'>
        <label for='name'>Name</label>
        <input type='text' value='rob' name='name'>
        <input type='submit' value='Save' name='commit'>
      </form>
    RESULT
    actual_result = HexletCode.form_for(@user) do |f|
      f.input :name
      f.submit
    end
    assert_equal shorten(expected_result), actual_result
  end

  def test_form_for_generates_submit_with_different_value
    expected_result = <<-RESULT
      <form action='#' method='post'>
        <label for='name'>Name</label>
        <input type='text' value='rob' name='name'>
        <input type='submit' value='Do it' name='commit'>
      </form>
    RESULT
    actual_result = HexletCode.form_for(@user) do |f|
      f.input :name
      f.submit 'Do it'
    end
    assert_equal shorten(expected_result), actual_result
  end
end
