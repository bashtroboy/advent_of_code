dice_rolls = 0
dice_number = 0
turn = 1

class Player
    attr_accessor :score
    attr_accessor :position
    
    def initialize(score, pos)
        @score = score
        @position = pos
    end
end 

p1 = Player.new(0, 8)
p2 = Player.new(0, 3)

until p1.score > 999 || p2.score > 999
    move_spaces = 0 # temp counter to see where the player needs to move
    3.times do
        dice_rolls += 1
        dice_number += 1
        move_spaces += dice_number
    end
    if turn == 1
        (move_spaces + p1.position)%10 == 0 ? p1.position = 10 : p1.position = ((move_spaces + p1.position)%10)
        p1.score += p1.position
        turn = 2
    else
        (move_spaces + p2.position)%10 == 0 ? p2.position = 10 : p2.position = ((move_spaces + p2.position)%10)
        p2.score += p2.position       
        turn = 1
    end
end

if p1.score < p2.score
    p "P2 wins, P1s score is: "
    p p1.score * dice_rolls
elsif p2.score < p1.score
    p "P1 wins, P2s score is: "
    p p2.score * dice_rolls
end