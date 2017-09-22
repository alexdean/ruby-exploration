require 'benchmark'

module Wrapper
  def wrap(method)
    wrapper_module = Module.new do
      define_method(method) do |*args|
        out = "in wrapper, before calling target\n"
        out += super(*args) + "\n"
        out += "in wrapper, after calling target"
        out
      end
    end
    prepend wrapper_module
  end
end

class Wrapped
  extend Wrapper

  def target(arg1, arg2)
    "in target. args:[#{arg1}, #{arg2}]"
  end
  wrap :target
end

class Unwrapped
  def target(arg1, arg2)
    "in target. args:[#{arg1}, #{arg2}]"
  end
end


puts(<<-EOF
this demonstrates how a method can be wrapped by other functionality
using prepend and an anonymous module

EOF
)
puts Wrapped.new.target(5, 6)


puts
puts "and now a benchmark"
puts

n = 1_000_000
Benchmark.bmbm do |x|
  x.report('wrapped') do
    n.times { Wrapped.new.target(5, 6) }
  end

  x.report('unwrapped') do
    n.times { Unwrapped.new.target(5, 6) }
  end
end
