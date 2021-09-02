# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_tag_build_without_args
    assert_equal '<br>', HexletCode::Tag.build('br')
  end

  def test_tag_build_with_args
    assert_equal "<input type='submit' value='Save'>",
                 HexletCode::Tag.build('input', type: 'submit', value: 'Save')
  end

  def test_tag_build_with_args_and_block
    assert_equal "<label for='email'>Email</label>",
                 HexletCode::Tag.build('label', for: 'email') { 'Email' }
  end
end
