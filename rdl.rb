require 'rdl'
require 'benchmark'

class WithRdl
  extend RDL::Annotate
  pre { |x| x > 0 }
  post { |r,x| r > 0 }
  def run(x)
    x
  end
end


class WithoutRdl
  def run(x)
    x
  end
end

with = WithRdl.new
without = WithoutRdl.new

puts "looking at the performance implications of RDL."
puts "https://github.com/plum-umd/rdl"
puts
puts "using ruby #{RUBY_VERSION}"
puts

n = 1_000_000
Benchmark.bmbm do |x|
  x.report('with_rdl') do
    n.times { with.run(1) }
  end

  x.report('without_rdl') do
    n.times { without.run(1) }
  end
end

