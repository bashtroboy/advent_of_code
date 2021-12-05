# variables

boards_file = File.read("data/input_day4_part2.txt")
input_file = File.read("data/input_day4_part1.txt")
board_array = []
input_array = []
board_count = 0
@winning_board = []
@already_won = false

# build boards and inputs into an array from data
boards_file.each_line do |line|
    if line == "\n"
        board_count += 1
    else  
        if board_array[board_count] == nil
            board_array[board_count] = []
            board_array[board_count] << line.split
        else  
            board_array[board_count] << line.split
        end
    end
end

def check_rows(board_array, input)
    board_array.each do |board|
        board.each do |row|
            if row & input == row
                if @already_won == false
                    @winning_board = board
                    @already_won = true
                    #print "Match row"
                end
                break
            end
        end
    end
end

def check_cols(board_array, input)
    board_array.each do |board|
        columns = board.transpose
        columns.each do |col|
            if col & input == col
                if @already_won == false
                    @winning_board = board
                    @already_won = true
                    #print "Match col"
                end
                break
            end
        end
    end
end

def calulate_score(input)
    sum_of_matrix = 0
    @winning_board.each do |row|
        row.each do |val|
            sum_of_matrix += val.to_i unless input.include?(val)
        end
    end
    print sum_of_matrix * input[-1].to_i
end

input_file.split(",") do |number|
    if @already_won == false
        input_array << number
        check_cols(board_array, input_array)
        check_rows(board_array, input_array)
    else
        calulate_score(input_array)
        break
    end
end
