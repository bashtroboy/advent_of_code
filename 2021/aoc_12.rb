@input = DATA.readlines.map(&:chomp).map {|x| x.split("-")}
@paths = []
@work = []

=begin
@input.each do |x|
    if (x[0] == x[0].upcase) && (x[0] != "start") && (x[1] != "end")
        unless @input.include? [x[1],x[0]]
            @input << [x[1],x[0]]
        end
    end
end
=end

def findNext(node, path)
    count = 0
    kids = []
    loopz = false
    parent = ""

    @input.each do |input|
        if input[0] == node
            count += 1 
            kids << input
            if (input[0] == input[0].upcase) && (input[0] != "start") && (input[1] != "end")
                loopz = true
                parent = input[0]
            end
        end
    end

    kids.each do |x|
        newPath = []
        newPath = path.dup
        newPath << x[1]
        if x[1] == "end"
            @paths << newPath
        end
        findNext(x[1], newPath)
        if loopz == true
            newPath2 = []
            newPath2 = newPath.dup
            newPath2 << parent
            newPath2 << x[1]
            @paths << newPath2
            findNext(parent, newPath2)
        end
    end
end

findNext("start", ["start"])

print @paths


__END__
start-A
start-b
A-c
A-b
b-d
A-end
b-end