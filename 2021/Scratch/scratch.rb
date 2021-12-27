
def parse_input(string)
  string.each_line(chomp: true)
end
def tokenize(string)
  string.scan(/\[|\]|\d+|,/).map { _1.match?(/^\d+$/) ? _1.to_i : _1 }
end

def explode(string)
  tokens = tokenize(string)
  nesting = 0

  tokens.length.times do |index|
    case tokens[index]
    when '['
      nesting += 1
      if nesting > 4
        # explode here!

        # pair is the following tokens, starting at this index: [ digit , digit ]
        left = tokens[index + 1]
        right = tokens[index + 3]
        tokens[index, 5] = 0

        # find index to the left to add to
        (index - 1).downto(0) do |left_index|
          if tokens[left_index].is_a?(Integer)
            tokens[left_index] += left
            break
          end
        end

        # find index to the right to add to
        (index + 1).upto(tokens.length - 1) do |right_index|
          if tokens[right_index].is_a?(Integer)
            tokens[right_index] += right
            break
          end
        end

        break
      end
    when ']'
      nesting -= 1
    end
  end

  tokens.join
end
def split(string)
  tokens = tokenize(string)

  tokens.length.times do |index|
    element = tokens[index]
    if element.is_a?(Integer) && element >= 10
      # split here!
      tokens[index, 1] = tokenize(add(
        (element / 2.0).floor,
        (element / 2.0).ceil,
      ))
      break
    end
  end

  tokens.join
end

def add(left, right)
  "[#{left},#{right}]"
end

def reduce(number)
  prev = nil

  until prev == number
    prev = number
    exploded_number = explode(number)
    number = if exploded_number == number
      split(number)
    else
      exploded_number
    end
  end

  number
end

def sum_list(numbers)
  numbers.inject do |left, right|
    reduce(add(left, right))
  end
end

def magnitude(number)
  # To check whether it's the right answer, the snailfish teacher only checks
  # the magnitude of the final sum. The magnitude of a pair is 3 times the
  # magnitude of its left element plus 2 times the magnitude of its right
  # element. The magnitude of a regular number is just that number.

  number = number.dup # cause of frozen strings

  until number =~ /^\d+$/
    m = number.match(/\[(?<left>\d+),(?<right>\d+)\]/)
    index = m.begin(0)
    length = m[0].length
    left = m[:left].to_i
    right = m[:right].to_i

    number[index, length] = (3 * left + 2 * right).to_s
  end

  number.to_i
end

def part1(numbers)
  magnitude(sum_list(numbers))
end

def part2(numbers)
  # What is the largest magnitude you can get from adding only two of the snailfish numbers?

  numbers.to_a.permutation(2).map { magnitude(sum_list(_1)) }.max
end


  input = parse_input(File.read('input_day18.txt'))
  puts "Part 1: #{part1(input)}"
  puts "Part 2: #{part2(input)}" rescue nil
