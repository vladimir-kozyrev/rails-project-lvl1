# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_text_area
    expected_result = <<-RESULT
      <textarea cols='30' rows='40' name='job'>hexlet</textarea>
    RESULT
    actual_result = HexletCode::Inputs::TextArea.new(
      'hexlet', cols: 30, rows: 40, name: 'job'
    ).to_s
    assert_equal shorten(expected_result), actual_result
  end
end
