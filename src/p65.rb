def eTerms()
    Enumerator.new do |g|
      [2, 1, 2].each do |a| g.yield a end
      (2..).each do |k|
        [1, 1, k * 2].each do |a| g.yield a end
      end
    end
  end
  
  def expandFraction(terms)
    r = nil
    terms.reverse.each do |a|
      r = Rational(a) + (r ? 1/r : 0)
    end
    r
  end
  
  def solve(n)
    numerator = expandFraction(eTerms.take(n)).numerator
    sum = 0
    while numerator > 0 do
      sum += numerator % 10
      numerator /= 10
    end
    sum
  end
  
  puts(solve(100))
  