puts '## example 1'

begin
  raised = false
  raise "nope."
rescue => e
  raised = true
ensure
  puts "ensure is executed after a rescue."
  puts "a var set in a `rescue` is available in `ensure`? #{raised}"
end

puts
puts '## example 2'

begin
  raised = false
rescue => e
ensure
  puts "an ensure is run even if no raise happens."
  puts "in an ensure... was an exception raised? #{raised}"
end

# puts
# puts '## example 3'

# begin
#   raise 'nope'
# rescue => e
#   puts 'handling exception in rescue and re-raising'
#   raise e
# ensure
#   puts 'and ensure is executed before re-raise'
# end

puts
puts '## example 4'

def will_ensure_and_reraise
  begin
    raise 'raising in a method'
  rescue => e
    puts 'methods `rescue` handles and re-raises'
    raise e
  ensure
    puts 'methods `ensure` is executed before re-raise'
  end
end

begin
  will_ensure_and_reraise
ensure
  puts 'then outermost `ensure` runs'
end
