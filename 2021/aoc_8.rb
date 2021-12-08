=begin
0 : 6 segments
1 : 2 segments
2 : 5 segments
3 : 5 segments
4 : 4 segments
5 : 5 segments
6 : 6 segments
7 : 3 segments
8 : 7 segments
9 : 6 segments

Unique numbers: 1(2), 4(4), 7(3), 8(7)
6 segments: 0, 6, 9
5 segments: 2, 3, 5
=end
@input_array = File.read("data/input_day8.txt")

def part1()
    count = 0

    @input_array.each_line do |line|
        line.chomp.split(" | ")[1].split(" ").each do |input|
            if [2,4,3,7].include? input.length.to_i
                count += 1
            end
        end
    end

    return count
end

def part2()
    decoded_array = []
    @input_array.each_line do |line|        
        
        # determine the pattern
        pattern = Hash.new
        output = line.chomp.split(" | ").first.split(" ")
        one = output.select {|num| num.length == 2}.join()
        four = output.select {|num| num.length == 4}.join()
        seven = output.select {|num| num.length == 3}.join()
        eight = output.select {|num| num.length == 7}.join()

        3.times do |i|
            unless one.include? seven[i]
                pattern[:a] = seven[i]
            end
        end

        # count letter occurances
        letter_count = Hash.new
        letter_count[:a] = line.chomp.split(" | ").first.count('a')
        letter_count[:b] = line.chomp.split(" | ").first.count('b')
        letter_count[:c] = line.chomp.split(" | ").first.count('c')
        letter_count[:d] = line.chomp.split(" | ").first.count('d')
        letter_count[:e] = line.chomp.split(" | ").first.count('e')
        letter_count[:f] = line.chomp.split(" | ").first.count('f')
        letter_count[:g] = line.chomp.split(" | ").first.count('g')
        
        pattern[:b] = letter_count.key(6).to_s
        pattern[:c] = ""
        pattern[:d] = ""
        pattern[:e] = letter_count.key(4).to_s
        pattern[:f] = letter_count.key(9).to_s
        pattern[:g] = ""

        # find d
        four.each_char do |x|
            unless one.include? x
                unless x == pattern[:b]
                    pattern[:d] = x
                end
            end
        end

        four.each_char do |y|
            unless [pattern[:b], pattern[:d], pattern[:f]].include? y
                pattern[:c] = y
            end
        end

        # find g
        ["a","b","c","d","e","f","g"].each do |z|
            unless pattern.has_value?(z)
                pattern[:g] = z
            end
        end

        pattern_code_0 = [pattern[:a],pattern[:b],pattern[:c],pattern[:e],pattern[:f],pattern[:g]].join.chars.sort.join
        pattern_code_2 = [pattern[:a],pattern[:c],pattern[:d],pattern[:e],pattern[:g]].join.chars.sort.join
        pattern_code_3 = [pattern[:a],pattern[:c],pattern[:d],pattern[:f],pattern[:g]].join.chars.sort.join
        pattern_code_5 = [pattern[:a],pattern[:b],pattern[:d],pattern[:f],pattern[:g]].join.chars.sort.join
        pattern_code_6 = [pattern[:a],pattern[:b],pattern[:d],pattern[:e],pattern[:f],pattern[:g]].join.chars.sort.join
        pattern_code_9 = [pattern[:a],pattern[:b],pattern[:c],pattern[:d],pattern[:f],pattern[:g]].join.chars.sort.join
        
        # decode
        scramble = line.chomp.split(" | ").last.split(" ")
        decoded_number = ""
        scramble.each do |digit|
            digit_code = digit.chars.sort.join

            if digit_code.length == 2
                decoded_number += "1"
            elsif digit_code.length == 4
                decoded_number += "4"
            elsif digit_code.length == 3
                decoded_number += "7"
            elsif digit_code.length == 7
                decoded_number += "8"
            elsif digit_code == pattern_code_0
                decoded_number += "0"
            elsif digit_code == pattern_code_2
                decoded_number += "2"
            elsif digit_code == pattern_code_3
                decoded_number += "3"
            elsif digit_code == pattern_code_5
                decoded_number += "5"
            elsif digit_code == pattern_code_6
                decoded_number += "6"
            elsif digit_code == pattern_code_9
                decoded_number += "9"
            end
        end
        decoded_array << decoded_number.to_i
    end
    return decoded_array.sum
end

print "Part 1: " + part1().to_s
puts " "
print "Part 2: " + part2().to_s