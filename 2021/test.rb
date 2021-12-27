TEST_INPUT = <<-INPUT
..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#
​
#..#.
#....
##..#
..#..
..###
INPUT

# every generation potentially expands out by one in each direction

require 'set'


def parse_input(string)
  enhancement_section, image_section = string.split("\n\n")

  enhancement_set = enhancement_section.chomp.each_char.with_index
    .select { |char, _index| char == '#' } # "#" is light, "." is dark
    .map(&:last) # index
    .to_set

  image_lit_pixels = Set.new
  image_section.each_line(chomp:true).map(&:chars).each_with_index do |row, row_index|
    row.each_with_index do |char, column_index|
      # columns are x, rows are y
      image_lit_pixels.add([column_index, row_index]) if char == "#"
    end
  end

  [
    Enhancer.new(enhancement_set), # set of pixel values that should be lit upon enhancement
    Image.new(image_lit_pixels), # set of pixel coordinates which are lit
  ]
end

class Image
  def initialize(lit_coordinates, void_lit: false)
    @lit_coordinates = lit_coordinates
    @void_lit = void_lit
  end

  def enhance_with(enhancer)
    new_lit_coordinates = extended_column_range.flat_map do |column_index|
      extended_row_range.filter_map do |row_index|
        coordinates = [column_index, row_index]

        enhancer.light?(enhancement_index_for(coordinates)) && coordinates
      end
    end.to_set

    new_void_lit = enhancer.light_void?(void_lit?)

    Image.new(new_lit_coordinates, void_lit: new_void_lit)
  end

  def render(buffer: 0)
    ((row_range.begin - buffer)..(row_range.end + buffer)).map do |row_index|
      ((column_range.begin - buffer)..(column_range.end + buffer)).map do |column_index|
        lit?([column_index, row_index]) ? '#' : '.'
      end.join
    end.join("\n")
  end

  def num_lit
    lit_coordinates.size
  end
  alias_method :size, :num_lit

  private

  def enhancement_index_for(coordinates)
    column, row = coordinates

    [
      lit?([column - 1, row - 1]),
      lit?([column    , row - 1]),
      lit?([column + 1, row - 1]),

      lit?([column - 1, row    ]),
      lit?([column    , row    ]),
      lit?([column + 1, row    ]),

      lit?([column - 1, row + 1]),
      lit?([column    , row + 1]),
      lit?([column + 1, row + 1]),
    ].map { _1 ? 1 : 0 }.join.to_i(2)
  end

  def lit?(coordinates)
    if within_bounds? coordinates
      lit_coordinates.include? coordinates
    else
      void_lit?
    end
  end

  def within_bounds?(coordinates)
    column, row = coordinates

    column_range.include?(column) && row_range.include?(row)
  end

  def extended_column_range
    (column_range.begin - 1)..(column_range.end + 1)
  end

  def extended_row_range
    (row_range.begin - 1)..(row_range.end + 1)
  end

  def column_range
    @column_range ||= lit_coordinates.map(&:first).minmax.then { _1.._2 }
  end

  def row_range
    @row_range ||= lit_coordinates.map(&:last).minmax.then { _1.._2 }
  end

  attr_reader :lit_coordinates

  def void_lit?
    @void_lit
  end
end

class Enhancer
  def initialize(set)
    @set = set
  end

  attr_reader :set

  def light?(value)
    set.include?(value)
  end

  def light_void?(void_lit)
    set.include?(void_lit ? 511 : 0)
  end
end
def part1(input)
  enhancer, image = input

  2.times do |i|
    image = image.enhance_with(enhancer)
  end

  image.size
end
def part2(input)
  enhancer, image = input

  50.times do |i|
    image = image.enhance_with(enhancer)
  end

  image.size
end


  input = parse_input(File.read('data/input_day20.txt'))

  # e, i0 = input
  # puts i0.render(buffer: 3) # shows unlit void
  # i1 = i0.enhance_with(e)
  # puts i1.render(buffer: 3) # shows   lit void
  # i2 = i1.enhance_with(e)
  # puts i2.render(buffer: 3) # shows unlit void

  puts "Part 1: #{part1(input)} \t(5479 is someone else's. 5537, 5525 are too low! 5573 was right)"
  puts "Part 2: #{part2(input)}" rescue nil
