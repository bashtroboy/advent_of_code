code = "#####.#.##.####.#....#.###.##.###.#..#.#...##....#.#.##..#...#..##.##.####.#....##.#.#......###..#.#.#...##.#...###...#.#...##....####....#...#.####..#.#.####....####..#..#..#....###...#..#.###.##..##..####....####.###..#.#.##.#.###.##....####.#####.##.#.#...##.######....##...#####.##..###.####.#.##..##...#.#..#.#.#.....#..#..##..##..######..#..#..##..#.##.#..###.#....#.#.#.#.#.#..#.##.#.#....###.#.#..#....#.##..##.##...#..#####.###.......###.###.#..#.##.######.#######.##..##.##..#.##......#####.#.....#..#."
plaingrid = []
@image = []
image2 = []

@gridsize = 5000

### Initialize grid and image
@gridsize.times do |x|
    plaingrid[x] = []
    @gridsize.times do |y|
        plaingrid[x][y] = "."
    end
end

@image = Marshal.load(Marshal.dump(plaingrid))

input = File.readlines("data/input_day20.txt")
input.each_with_index do |line, l|
    line.chomp.each_char.with_index do |char, c|
        @image[l+2000][c+2500] = char
    end
end

def get_code(x,y)
    digit = ""
    if 0 < x && x < (@gridsize - 1) && 0 < y && y < (@gridsize - 1)
        (x-1..x+1).each do |x2|
            (y-1..y+1).each do |y2|
                @image[x2][y2] == "#" ? digit += "1" : digit += "0"
            end
        end
    end
    return digit.to_i(2)
end

process_count = 0
50.times do 
    image2 = Marshal.load(Marshal.dump(plaingrid))
    @image.length.times do |x|
        @image[x].length.times do |y|
            image2[x][y] = code[get_code(x,y)]
        end
    end
    @image = Marshal.load(Marshal.dump(image2))
    p process_count += 1
end

# print final grid
count_lit = 0
(2..(@gridsize - 2)).each do |x|
    (2..(@gridsize - 2)).each do |y|
        @image[x][y] == "#" ? count_lit += 1 : nil
        #print @image[x][y]
    end
    #puts
end

p count_lit
