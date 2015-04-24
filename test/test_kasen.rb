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

  def setup
    @ary = [1, 2, 3]
    @arys = [[1, 2], [3, 4]]
  end

  def test_main
    t0 = @ary.map &k
    assert_equal @ary, t0

    t1 = @ary.map &k.to_s
    assert_equal @ary.map(&:to_s), t1

    t2 = @ary.map &k.+(1)
    assert_equal @ary.map { |n| n + 1 }, t2

    t3 = @ary.map &k.+(1).-(2)
    assert_equal @ary.map { |n| n + 1 - 2 }, t3

    t4 = @ary.select &k.>(1)
    assert_equal @ary.select { |n| n > 1 }, t4

    t5 = @arys.each &k.map!(&k.to_s)
    assert_equal @arys.each { |ary| ary.map! { |n| n.to_s } }, t5
  end
end
