code_array = []
@code_hash = Hash.new
input = DATA.readlines.map(&:chomp).each {|x| code_array << x.split(" -> ")}
code_array.each { |code| @code_hash[code[0]] = code[1] }
@initial_template = "SVCHKVFKCSHVFNBKKPOC"

def part1
    template = @initial_template

    10.times do 
        new_template = ""
        template.each_char.with_index do |char, i|
            unless template[i+1] == nil
                next_char = template[i+1]
                new_template += char + @code_hash[char + next_char]
            end
            i == template.length - 1 ? new_template += char : nil
        end
        template = new_template
        print "#"
    end

    count_hash = Hash.new
    template.each_char do |element|
        count_hash[element] == nil ? count_hash[element] = 1 : count_hash[element] += 1
    end

    return count_hash.values.max - count_hash.values.min
end

p "Part 1: " + part1.to_s
puts

__END__
NC -> H
PK -> V
SO -> C
PH -> F
FP -> N
PN -> B
NP -> V
NK -> S
FV -> P
SB -> S
VN -> F
SC -> H
OB -> F
ON -> O
HN -> V
HC -> F
SN -> K
CB -> H
OP -> K
HP -> H
KS -> S
BC -> S
VB -> V
FC -> B
BH -> C
HH -> O
KH -> S
VF -> F
PF -> P
VV -> F
PP -> V
BO -> H
BF -> B
PS -> K
FO -> O
KF -> O
FN -> H
CK -> B
VP -> V
HK -> F
OV -> P
CS -> V
FF -> P
OH -> N
VS -> H
VO -> O
CP -> O
KC -> V
KV -> P
BK -> B
VK -> S
NF -> V
OO -> V
FH -> H
CN -> O
SP -> B
KN -> V
OF -> H
NV -> H
FK -> B
PV -> N
NB -> B
KK -> P
VH -> P
CC -> B
HV -> V
OC -> H
PO -> V
NO -> O
BP -> C
NH -> H
BN -> O
BV -> S
CV -> B
HS -> O
NN -> S
NS -> P
KB -> F
CO -> H
HO -> P
PB -> B
BS -> P
SH -> H
FS -> V
SF -> O
OK -> F
KP -> S
BB -> C
PC -> B
OS -> C
SV -> N
SK -> K
KO -> C
SS -> V
CF -> C
HB -> K
VC -> B
CH -> P
HF -> K
FB -> V