input = File.read("data/input_day10.txt")
score = 0

PARENS = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">"
}

OPEN_PARENS = PARENS.keys
CLOSE_PARENS = PARENS.values

def checkIfValid(string)
    stack = []

    string.each_char do |char|
        if OPEN_PARENS.include?(char)
            stack << char
        elsif CLOSE_PARENS.include?(char)
            char == PARENS[stack.last] ? stack.pop : (return ["corrupt",char])
        end
    end
    stack.any? { return ["incomplete",nil] }
end

input.each_line do |line|
    check = checkIfValid(line) 
    case check.last
    when ")"
        score += 3
    when "]"
        score += 57
    when "}"
        score += 1197
    when ">"
        score += 25137
    end
end

print score