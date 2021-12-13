input = File.readlines("data/input_day13.txt")
@grid = []
@instructions = []
printout = []

input.each do |line|
    @grid << line.chomp.split(",").map(&:to_i)
end

def fold(direction,line)
    axis = direction == "x" ? 0 : direction == "y" ? 1 : nil
    unless axis == nil
        @grid.each do |coord|
            if coord[axis] > line
                coord[axis] = (2*line) - coord[axis]
            end
        end
        @grid = @grid.uniq
        return @grid.count
    end
end

#part 1
p "Part 1: " + fold("x",655).to_s

#part 2
p "Part 2: "
puts
instructionsInput = DATA.readlines
instructionsInput.each do |line|
    @instructions << line.chomp.delete("fold along ").split("=")
end

@instructions.each do |ins|
    fold(ins[0],ins[1].to_i)
end

#get new grid dimentions
maxx = 0
maxy = 0

@grid.each do |z|
    z[0] > maxx ? maxx = z[0] : nil
    z[1] > maxy ? maxy = z[1] : nil
end
 
(0..maxy).each do |y|
    (0..maxx).each do |x|
        if @grid.include? [x,y]
            print "#"   
        else
            print " "
        end
    end
    puts
end

# fold instructions
__END__
fold along y=447
fold along x=327
fold along y=223
fold along x=163
fold along y=111
fold along x=81
fold along y=55
fold along x=40
fold along y=27
fold along y=13
fold along y=6