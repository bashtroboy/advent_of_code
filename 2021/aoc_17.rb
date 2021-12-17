@target_x = (179..201)
@target_y = (-109..-63)
largest_y = []
valid_inputs = []

def check_for_target(vel_x, vel_y)
    x = 0
    y = 0
    y_array = []

    loop do
        x += vel_x
        y += vel_y

        y_array << y

        vel_x > 0 ? vel_x -= 1 : vel_x == 0
        vel_y -= 1

        if @target_x.include?(x) && @target_y.include?(y)
            return y_array.max
        end

        if x > @target_x.max || y < @target_y.min 
            break
        end
    end
end

(-500..500).each do |x|
    (-500..500).each do |y|
        response = check_for_target(x,y) 
        if response != nil 
            largest_y << response
            valid_inputs << [x,y]
        end
    end
end

p "Part 1: #{largest_y.max}"
puts
p "Part 2: #{valid_inputs.count}"