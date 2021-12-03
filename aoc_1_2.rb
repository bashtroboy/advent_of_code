#depths = []
depths = File.read("data/input_day1.txt").split("\n").map(&:to_i)
changes = 0
last_window = nil
depths.each_with_index do |val,i|
  break if i > depths.count - 3
  window = [val, depths[i + 1], depths[i + 2]]
  current_window = window.sum
  if last_window.nil?
    last_window = current_window
    next
  end
  changes += 1 if current_window > last_window
  last_window = current_window
end
puts changes