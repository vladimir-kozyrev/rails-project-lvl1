# frozen_string_literal: true

require "test_helper"

class HexletCodeTest < Minitest::Test
  def setup
    user_class = Struct.new(:name, :job, :gender, :foo, :bar, keyword_init: true)
    @user = user_class.new name: "rob", job: "hexlet", gender: "m", foo: "", bar: nil
  end

  def shorten(text)
    text.split("\n").map(&:strip).join("\n")
  end

  def test_form_for_without_url
    expected_result = <<-RESULT
      <form action="#" method="post">
      </form>
    RESULT
    assert_equal shorten(expected_result), HexletCode.form_for(@user)
  end

  def test_form_for_with_url
    expected_result = <<-RESULT
      <form action="/users" method="post">
      </form>
    RESULT
    assert_equal shorten(expected_result), HexletCode.form_for(@user, url: "/users")
  end

  def test_form_for_generates_form_with_input
    expected_result = <<-RESULT
      <form action="#" method="post">
        <input type="text" value="rob" name="name">
      </form>
    RESULT
    assert_equal shorten(expected_result),
                 HexletCode.form_for(@user) { |f| f.input :name }
  end

  def test_form_for_raises_if_input_is_not_set
    assert_raises RuntimeError, "The user does not have such method" do
      HexletCode.form_for(@user) { |f| f.input :dog }
    end
  end

  def test_form_for_raises_if_input_is_empty_or_nil
    assert_raises RuntimeError, "The field value for this user is not set" do
      HexletCode.form_for(@user) { |f| f.input :foo }
    end
    assert_raises RuntimeError, "The field value for this user is not set" do
      HexletCode.form_for(@user) { |f| f.input :bar }
    end
  end

  def test_form_for_generates_form_with_text_input
    expected_result = <<-RESULT
      <form action="#" method="post">
        <textarea cols="20" rows="40" name="job">hexlet</textarea>
      </form>
    RESULT
    assert_equal shorten(expected_result),
                 HexletCode.form_for(@user) { |f| f.input :job, as: :text }
  end

  def test_form_for_generates_form_with_select_input
    expected_result = <<-RESULT
      <form action="#" method="post">
        <select name="gender">
          <option value="m" selected>m</option>
          <option value="f">f</option>
        </select>
      </form>
    RESULT
    assert_equal shorten(expected_result),
                 HexletCode.form_for(@user) { |f| f.input :gender, as: :select, collection: %w[m f] }
  end
end
