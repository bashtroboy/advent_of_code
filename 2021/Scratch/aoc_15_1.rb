maxint = (2**(0.size * 8 -2) -1)
costs = Hash.new
@previous = []
@start_vertex = [0,0]
@end_vertex = [3,3]
@grid = []
@next_steps = []


DATA.readlines.each do |line| 
    row = []
    line.chomp.each_char do |ch|
        row << ch.to_i
    end
    @grid << row
end

def find_next_nodes(x,y)
    neighbours = []
    # north
    (y > @start_vertex[1]) && (@previous & [[x,y-1]] == []) ? neighbours << [x,y-1] : nil
    # east
    (x < @end_vertex[0]) && (@previous & [[x+1,y]] == [])  ? neighbours << [x+1,y] : nil
    # south
    (y < @end_vertex[1]) && (@previous & [[x,y+1]] == []) ? neighbours << [x,y+1] : nil
    # west
    (x > @start_vertex[0]) && (@previous & [[x-1,y]] == []) ? neighbours << [x-1,y] : nil
    return neighbours
end

2.times do
    find_next_nodes(x=0,y=0).each do |cost|
        costs[cost] = [@grid[cost[0]][cost[1]],[x,y]]
        find_next_nodes(cost[0],cost[1])
    end
end

print costs 

__END__
1163
1381
2136
3694