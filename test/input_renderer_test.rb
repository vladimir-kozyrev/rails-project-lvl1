# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_input_renderer
    input = { as: :text, name: 'job', value: 'hexlet', cols: 30, rows: 40 }
    expected_result = File.open("#{__dir__}/fixtures/input_renderer.html")
    rendered_input = HexletCode::FormRenderer::InputRenderer.new(input).render
    assert_equal expected_result.read, rendered_input
  end
end
