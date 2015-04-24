require 'minitest_helper'

class TestKasen < Minitest::Test
  def test_readme_examples
    assert_equal(
      [[1, 2], [3, 4]].map { |ary| ary[1] },
      [[1, 2], [3, 4]].map(&k[1])
    )

    assert_equal(
      ['0', '1', '2'].select { |s| s.to_i.zero? },
      ['0', '1', '2'].select(&k.to_i.zero?)
    )

    assert_equal(
      [['1', '2'], ['3', '4']].map { |ary| ary.select { |n| n.to_i.eql?(1) } },
      [['1', '2'], ['3', '4']].map(&k.select(&k.to_i.eql?(1)))
    )
  end
end
