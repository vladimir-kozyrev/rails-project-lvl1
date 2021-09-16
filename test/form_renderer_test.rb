# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_form_renderer
    form = [
      { as: :text, input_name: 'job', input_value: 'hexlet', cols: 30, rows: 40 },
      { input_name: 'input', input_value: 'Save', type: 'submit', name: 'commit' }
    ]
    renderer = HexletCode::FormRenderer.new(form, nil)
    expected_result = <<-RESULT
    <form action='#' method='post'>
      <label for='job'>Job</label>
      <textarea cols='30' rows='40' name='job'>hexlet</textarea>
      <input type='submit' value='Save' name='commit'>
    </form>
    RESULT
    assert_equal shorten(expected_result), renderer.render
  end
end
