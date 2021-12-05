input_file = File.read("data/input_day5test.txt")
raw_array = []
clean_array = []
plot_array = []
plot_hash = Hash.new

# create an array of input coordinates
input_file.each_line do |val|
    raw_array << val.chomp.split(" -> ")
end

clean_array = raw_array.map{|row| row.map{|col| col.split(",").map(&:to_i)}}


# create a hash of grid with 0 as a value for each grip coord
10.times {|x| 10.times {|y| plot_array << [x,y]}}

plot_array.each do |coord|
    plot_hash[coord] = 0
end

def mark_vertical (y, start, range)
    (range += 1).times do |i|
        print start + i
    end 
end

# mark the grid
clean_array.each do |input|
    if input[0][0] == input[1][0] #vertical
        if input[0][1] > input[1][1]
            mark_vertical(input[0][0],input[1][1], input[0][1]-input[1][1])
        else
            mark_vertical(input[0][0],input[0][1], input[1][1]-input[0][1])
        end
    elsif input[0][1] == input[1][1] #horizontal

    end
end
#print plot_hash