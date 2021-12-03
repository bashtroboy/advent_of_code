
gen_array = []
scrub_array = []

diagnostic_report = File.read("data/input_day3.txt")

# create a clean array of reports
diagnostic_report.each_line(chomp: true) do |report|
    gen_array  << report
    scrub_array  << report
end

report_length = gen_array[0].length # how many digit placeholders are we dealing with?

for q in 0..report_length
    bit_count = 0

    gen_array.each_with_index do |val, index|
        if val[q].to_i == 1
            bit_count += 1
        end
    end

    new_array = []

    if bit_count > gen_array.count / 2
        gen_array.each do |row|
            if row[q].to_i == 1
                new_array << row
            end
        end
    elsif bit_count.to_f == gen_array.count.to_f / 2
        gen_array.each do |row|
            if row[q].to_i == 1
                new_array << row
            end
        end
    else
        gen_array.each do |row|
            if row[q].to_i == 0
                new_array << row
            end
        end
    end

    if scrub_array.count == 1
        break
    end
    
    gen_array = new_array
end

for q in 0..report_length
    bit_count = 0

    scrub_array.each_with_index do |val, index|
        if val[q].to_i == 1
            bit_count += 1
        end
    end

    new_array = []

    if bit_count > scrub_array.count / 2
        scrub_array.each do |row|
            if row[q].to_i == 0
                new_array << row
            end
        end
    elsif bit_count.to_f == scrub_array.count.to_f / 2
        scrub_array.each do |row|
            if row[q].to_i == 0
                new_array << row
            end
        end
    else
        scrub_array.each do |row|
            if row[q].to_i == 1
                new_array << row
            end
        end
    end
    if scrub_array.count == 1
        break
    end

    scrub_array = new_array
end
puts scrub_array[0].to_i(2) * gen_array[0].to_i(2)
