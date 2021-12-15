input_file = File.read("data/input_day6test.txt")
fish_array = []

# create an array of initial fishies
fish_array = input_file.split(",").map(&:to_i)

p fish_array