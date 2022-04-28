require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

LANGUAGE = 'en'

# set up methods
def prompt(text)
  message = messages(text, LANGUAGE)
  puts "=> #{message}"
end

# Test if number is integer
def integer?(number)
  number.to_i.to_s == number
end

# Test if number is float
def float?(number)
  number.to_f.to_s == number || number.to_i.to_s + '.' == number
end

# Test if input is a number
def number?(number)
  integer?(number) || float?(number)
end

# retrieve message is specified language from yaml file
def messages(text, language = 'en')
  MESSAGES[language][text]
end

# Asks user for number
def get_number
  loop do
    prompt('get_number')
    num = gets.chomp

    if number?(num)
      if float?(num)
        break num.to_f
      else
        break num.to_i
      end
    else
      prompt('not_number')
    end
  end
end

# asks user for valid operation
def get_operation
  operation = ''
  until %w(1 2 3 4).include?(operation)
    prompt('invalid_operation') unless operation.empty?
    prompt('operation')
    operation = gets.chomp
  end
  operation
end

# returns array [result,operator]
def result_and_operator(operation, num1, num2)
  case operation
  when '1'
    [num1 + num2, '+']
  when '2'
    [num1 - num2, '-']
  when '3'
    [num1 * num2, 'x']
  when '4'
    [(num1.to_f / num2).round(2), '/']
  end
end

# dun dun duuuun
def dramatic_pause
  print "Calculating"
  3.times do
    print "."
    sleep(0.5)
  end
  puts "\n\n"
end

# ask user if they would like to recalculate
def play_again
  prompt('again')
  gets.chomp.upcase
end

# main body of code
loop do
  system('clear')
  num1 = get_number
  num2 = get_number
  operation = get_operation
  result, operator = result_and_operator(operation, num1, num2)
  dramatic_pause
  puts "#{num1} #{operator} #{num2} = #{result}"

  break unless play_again.start_with?('Y')
end