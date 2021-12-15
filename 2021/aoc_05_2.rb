input_file = File.read("data/input_day5.txt")
raw_array = []
clean_array = []
plot_array = []
@plot_hash = Hash.new

# create an array of input coordinates
input_file.each_line do |val|
    raw_array << val.chomp.split(" -> ")
end

clean_array = raw_array.map{|row| row.map{|col| col.split(",").map(&:to_i)}}


# create a hash of grid with 0 as a value for each grip coord
1000.times {|x| 1000.times {|y| plot_array << [x,y]}}

plot_array.each do |coord|
    @plot_hash[coord] = 0
end

def mark_vertical (x, start, range)
    (range += 1).times do |i|
        @plot_hash[[x, start+i]] += 1
    end 
end

def mark_horizontal (y, start, range)
    (range += 1).times do |i|
        @plot_hash[[start+i,y]] += 1
    end 
end

def mark_diagonal (coords)
    startx = coords[0][0]
    starty  = coords[0][1]
    rangex = coords[1][0] - coords[0][0]
    if coords[1][1] > coords[0][1]
        rangey = coords[1][1] - coords[0][1]
        (rangex += 1).times do |i|
            @plot_hash[[startx+i,starty+i]] += 1
        end
    else
        rangey = coords[0][1] - coords[1][1]
        (rangex += 1).times do |i|
            @plot_hash[[startx+i,starty-i]] += 1
        end
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
        if input[0][0] > input[1][0]
            mark_horizontal(input[0][1],input[1][0], input[0][0]-input[1][0])
        else
            mark_horizontal(input[0][1],input[0][0], input[1][0]-input[0][0])
        end
    else
        if input[0][0] < input[1][0]
            mark_diagonal(input)
        else
            mark_diagonal([input[1],input[0]])
        end
    end
end


# count overlaps
overlaps = 0
@plot_hash.each do |key,value| 
    if value >= 2 
        overlaps +=1
    end
end

#print @plot_hash

print overlaps  
