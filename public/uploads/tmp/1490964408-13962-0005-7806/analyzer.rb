def multiply(first_number, second_number)
  first_number * second_number
end

def divide(first_number, second_number)
  first_number / second_number
end

def subtract(first_number, second_number)
  second_number - first_number
end

def sum(first_number, second_number)
  first_number + second_number
end

def mod(first_number, second_number)
  first_number % second_number
end

puts "What you want to do? 1) multiply 2) divide 3) sum 4) subtract 5) mod?"
choice = gets.chomp.to_i

puts "Enter first number"
first_number = gets.chomp.to_i
puts "Enter second number"
second_number = gets.chomp.to_i

if choice == 1
  puts "multiply"
  puts multiply(first_number, second_number)
elsif choice == 2
  puts "divide"
  puts divide(first_number, second_number)
elsif choice == 3
  puts "sum"
  puts sum(first_number, second_number)
elsif choice == 4
  puts "subtract"
  puts subtract(first_number, second_number)
elsif choice == 5
  puts "mod"
  puts mod(first_number, second_number)
else
  puts "wrong enter"
end