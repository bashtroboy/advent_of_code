row = 0
grid = []
@lowPointsHash = Hash.new

DATA.read.each_line do |line|
    grid[row] = []
    line.chomp.chars.each_with_index do |val, i|
        grid[row] << val.to_i
    end
    row += 1
end

def setHash(plot,value)
    @lowPointsHash[plot] = value
end

grid.each_with_index do |row, irow|
    if irow == 0  # first row
        row.each_with_index do |val, i|
            if val < grid[irow+1][i]
                if i == 0
                    if (val < grid[irow][i+1])
                        setHash([irow,i],val)
                    end   
                elsif i == row.size - 1
                    if (val < grid[irow][i-1])
                        setHash([irow,i],val)
                    end
                else
                    if (val < grid[irow][i+1]) && (val < grid[irow][i-1])
                        setHash([irow,i],val)
                    end
                end
            end
        end
    elsif irow == grid.size - 1  # last row
        row.each_with_index do |val, i|
            if val < grid[irow-1][i]
                if i == 0
                    if (val < grid[irow][i+1])
                        setHash([irow,i],val)
                    end   
                elsif i == row.size - 1
                    if (val < grid[irow][i-1])
                        setHash([irow,i],val)
                    end
                else
                    if (val < grid[irow][i+1]) && (val < grid[irow][i-1])
                        setHash([irow,i],val)
                    end
                end
            end
        end
    else  # middle rows
        row.each_with_index do |val, i|
            if (val < grid[irow-1][i]) && (val < grid[irow+1][i])
                if i == 0
                    if (val < grid[irow][i+1])
                        setHash([irow,i],val)
                    end   
                elsif i == row.size - 1
                    if (val < grid[irow][i-1])
                        setHash([irow,i],val)
                    end
                else
                    if (val < grid[irow][i+1]) && (val < grid[irow][i-1])
                        setHash([irow,i],val)
                    end
                end
            end
        end        
    end
end

#print lowPoints
puts " "
print grid

=begin
x = 2
y = 2


depths = []
# work right
currentx = x
currenty = y
until grid[x][currenty] == 9 || grid[x][currenty] == nil
    currentx = x
    until grid[currentx][currenty] == 9 || grid[currentx][currenty] == nil
        print grid[currentx][currenty]
        currentx += 1
    end
    currentx = x-1
    until grid[currentx][currenty] == 9 || grid[currentx][currenty] == nil
        print grid[currentx][currenty]
        currentx -= 1
    end
    currenty += 1
end

# work left
currentx = x
currenty = y-1
until grid[x][currenty] == 9 || grid[x][currenty] == nil
    currentx = x
    until grid[currentx][currenty] == 9 || grid[currentx][currenty] == nil
        print grid[currentx][currenty]
        currentx += 1
    end
    currentx = x-1
    until grid[currentx][currenty] == 9 || grid[currentx][currenty] == nil
        print grid[currentx][currenty]
        currentx -= 1
    end
    currenty -= 1
end

=end 














__END__
2199943210
3987894921
9856789892
8767896789
9899965678