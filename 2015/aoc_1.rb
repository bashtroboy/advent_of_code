input = File.read("data/day_1.txt").chomp

def part1(input)
    floor = 0
    input.each_char {|move| move == ("(") ? floor += 1 : floor -= 1}
    return floor
end

def part2(input)
    floor = 0
    pos = 1
    input.each_char do |move| 
        move == ("(") ? floor += 1 : floor -= 1
        if floor == -1
            return pos
        end
        pos += 1
    end
end

print part1(input)
puts " "
print part2(input)