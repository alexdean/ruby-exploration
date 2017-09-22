class Thing
  attr_accessor :proc

  def instance_value
    "instance_value"
  end

  def formatted_value
    "~~~ #{instance_value} ~~~"
  end

  def initialize
    @proc = ->() { formatted_value }
  end

  def call
    @proc.call
  end
end

thing = Thing.new
thing.instance_value = "hello"

puts "we see formatted_value here, because the proc was defined in the class"
puts thing.call
puts

thing.proc = ->() { formatted_value }

puts "this will be an error, because `formatted_value` isn't defined in the scope the proc is defined"
puts thing.call
puts
