# frozen_string_literal: true

require "test_helper"

class HexletCodeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_tag_build_without_args
    assert_equal HexletCode::Tag.build("br"), "<br>"
  end

  def test_tag_build_with_args
    assert_equal HexletCode::Tag.build("input", type: "submit", value: "Save"),
                 "<input type=\"submit\" value=\"Save\">"
  end

  def test_tag_build_with_args_and_block
    assert_equal HexletCode::Tag.build("label", for: "email") { "Email" },
                 "<label for=\"email\">Email</label>"
  end
end
