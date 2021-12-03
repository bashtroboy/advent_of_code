horizontal = 0
depth = 0
aim = 0

file = File.open("data/input_day2.txt", "r")

file.each_line do |line|
    if line.include? "forward"
        horizontal += line[-2].to_i
        depth += (aim * line[-2].to_i)
    elsif line.include? "down"
        aim += line[-2].to_i
    elsif line.include? "up"
        aim -= line[-2].to_i
    end
end

puts horizontal * depth