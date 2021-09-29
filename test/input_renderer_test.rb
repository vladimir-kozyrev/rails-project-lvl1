# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_input_renderer
    input = { as: :text, name: 'job', value: 'hexlet', cols: 30, rows: 40 }
    expected_result = File.open("#{__dir__}/fixtures/input_renderer.html")
    rendered_input = HexletCode::InputRenderer.new(input, add_newline_for_label: false).render
    assert_equal expected_result.read, "#{rendered_input}\n"
  end
end
