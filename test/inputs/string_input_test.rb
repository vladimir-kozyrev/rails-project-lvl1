# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_string_input_without_block
    expected_result = <<-RESULT
      <input type='text' value='rob' name='name' class='woo'>
    RESULT
    actual_result = HexletCode::Inputs::StringInput.new(
      'input', type: 'text', value: 'rob', name: 'name', class: 'woo'
    ).to_s
    assert_equal shorten(expected_result), actual_result
  end

  def test_string_input_with_block
    expected_result = <<-RESULT
      <label for='name'>Name</label>
    RESULT
    actual_result = HexletCode::Inputs::StringInput.new('label', 'Name', for: 'name').to_s
    assert_equal shorten(expected_result), actual_result
  end
end
