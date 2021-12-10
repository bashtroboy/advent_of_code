input = File.read("data/input_day10.txt")
@all_scores = []
@incompletes = []

PARENS = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">"
}

OPEN_PARENS = PARENS.keys
CLOSE_PARENS = PARENS.values

def getValidStrings(string)
    stack = []

    string.each_char do |char|
        if OPEN_PARENS.include?(char)
            stack << char
        elsif CLOSE_PARENS.include?(char)
            char == PARENS[stack.last] ? stack.pop : (return ["corrupt",char])
        end
    end
    stack.any? { @incompletes << string.chomp }
end

input.each_line do |line|
    getValidStrings(line) 
end

@incompletes.each do |chunk|
    stack = []

    chunk.each_char do |char|
        if OPEN_PARENS.include?(char)
            stack << char
        elsif CLOSE_PARENS.include?(char)
            char == PARENS[stack.last] ? stack.pop : (return false)
        end
    end
    
    score = 0
    stack.reverse_each do |val|
        case val
        when "("
            score = (score*5) + 1
        when "["
            score = (score*5) + 2
        when "{"
            score = (score*5) + 3
        when "<" 
            score = (score*5) + 4
        end
    end
    @all_scores << score
end

print @all_scores.sort[@all_scores.length/2]