
def count_fish(days)
    input_file = File.read("data/input_day6.txt")
    fish_array = []

    # create an array of initial fishies
    fish_array = input_file.split(",").map(&:to_i)

    days.times do |i|
        print "Day " + i.to_s
        puts " "
        new_array = []
        new_fish = 0
        fish_array.length.times do |fish|
            case fish_array[fish]
            when 0
                new_array << 6
                new_fish += 1
            else
                new_array << (fish_array[fish] - 1)
            end
        end

        new_fish.times do ||
            new_array << 8
        end

        fish_array = new_array
    end
    return fish_array.count.to_s
end

print "Part 1:" + count_fish(80)
puts " "
print "Part 2:" + count_fish(256)