totalrows = 0
bit_count = []
gamma_rate = []
epsilon_rate = []

diagnostic_report = File.read("data/input_day3.txt")

# count the bits
diagnostic_report.each_line do |report|
    for i in 0..report.length
        if report[i].to_i == 1  #initialize array to length of report
            if bit_count[i] == nil
                bit_count[i] = 0
            end

            if  #if bit is 1, add to the array at that index
                bit_count[i] += 1
            end
        end
    end
    totalrows += 1
end

# compare the bit counts
bit_count.each_with_index do |val,index|
    if val > (totalrows - val)
        gamma_rate[index] = 1
        epsilon_rate[index] = 0
    else
        gamma_rate[index] = 0
        epsilon_rate[index] = 1       
    end
end

puts gamma_rate.join().to_i(2) * epsilon_rate.join().to_i(2)

