input_file = File.read("data/input_day6.txt")
fish_array = []
fish_hash = Hash.new
9.times { |x| fish_hash[x] = 0}  # init counting hash

# create an array and hash of initial fishies
fish_array = input_file.split(",").map(&:to_i)
fish_array.each { |y| fish_hash[y] += 1}

256.times do
    pond_hash = fish_hash.dup
    8.times do |fish|
        if fish == 0
            pond_hash[8] = fish_hash[0]
            pond_hash[0] = fish_hash[1]
        elsif fish == 6
            pond_hash[6] = fish_hash[0] + fish_hash[fish+1]
        else
            pond_hash[fish] = fish_hash[fish+1]
        end
    end
    fish_hash = pond_hash
end

p fish_hash.values.sum