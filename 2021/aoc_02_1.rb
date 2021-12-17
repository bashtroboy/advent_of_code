horizontal = 0
depth = 0

file = File.open("data/input_day2.txt", "r")

file.each_line do |line|
    if line.include? "forward"
        horizontal += line[-2].to_i
    elsif line.include? "down"
        depth += line[-2].to_i
    elsif line.include? "up"
        depth -= line[-2].to_i
    end
end

puts horizontal * depth