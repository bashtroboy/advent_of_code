$prev = 0
$count = 0

File.open("data/input_day1.txt", "r").each_line do |line|
    if line.to_i > $prev.to_i
        $count += 1
    end
    $prev = line
end 

print $count - 1