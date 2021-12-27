input = File.readlines("data/input_day22part1.txt")
instructions = []
offon = 0
cube = Hash.new
coords = []
x,y,z = 0

input.each_with_index do |line, l|
    instructions << line.chomp.split(" ")
end

instructions.each_with_index do |instruct, i|
    instruct[0] == "on" ? offon = 1 : offon = 0
    coords = instruct[1].split(",")
    coords.each_with_index do |axis, indx|
        instance_eval (coords[indx])
    end
    x.each do |x1|
        y.each do |y1|
            z.each do |z1|
                if offon == 1
                    cube["#{x1},#{y1},#{z1}"] = offon
                else
                    cube.delete("#{x1},#{y1},#{z1}")
                end
            end
        end
    end
    p "Line #: #{i}"
end

p cube.values.tally