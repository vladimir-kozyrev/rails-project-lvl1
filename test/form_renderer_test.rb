# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_input_renderer
    input = { as: :text, name: 'job', value: 'hexlet', cols: 30, rows: 40 }
    rendered_input = HexletCode::InputRenderer.new(input, add_newline_for_label: false).render
    expected_result = <<-RESULT
      <label for='job'>Job</label>
      <textarea name='job' cols='30' rows='40'>hexlet</textarea>
    RESULT
    assert_equal shorten(expected_result), rendered_input
  end
end
