# initialize input and grid
input = DATA.read
@allFlashGrid = []
@grid = []
@flashed = []
currentRow = 0

(0..9).each do |a|
    @allFlashGrid[a] = []
    (0..9).each do |b|
        @allFlashGrid[a][b] = 0
    end
end

input.each_line.with_index() do |line,i|
    @grid[i] = []
    line.chomp.each_char {|char| @grid[i] << char.to_i}
end

def increaseEnergy()
    @grid.each_with_index { |row,x| 
        row.each_with_index {|char, y| @grid[x][y] = char += 1
        } 
    }
end

def increase_neighbours(x,y)
    ((x-1)..(x+1)).each do |x2|
        ((y-1)..(y+1)).each do |y2|
            unless x == x2 && y == y2
                if (0..9).include?(x2) && (0..9).include?(y2)
                    unless @grid[x2][y2] == 0
                        @grid[x2][y2] += 1
                    end
                end
            end
        end
    end
end

def flashTime()
    @grid.each_with_index { |row,x| 
        row.each_with_index { |char, y| 
            if char > 9
                @flashed << [x,y]
                @grid[x][y] = 0
            end
        } 
    }
end

loop do
    currentRow += 1
    increaseEnergy()
    loop do
        @flashed = []
        flashTime()
        if @flashed == []
            break
        else
            @flashed.each do |coord|
                increase_neighbours(coord[0],coord[1])
            end
        end
    end 
    if @grid == @allFlashGrid
        print currentRow
        break
    end
end

__END__
8448854321
4447645251
6542573645
4725275268
6442514153
4515734868
5513676158
3257376185
2172424467
6775163586