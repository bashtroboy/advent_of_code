code_array = []
@code_hash = Hash.new
@pairs = Hash.new
input = DATA.readlines.map(&:chomp).each {|x| code_array << x.split(" -> ")}
code_array.each { |code| @code_hash[code[0]] = code[1] }

def init_pairs(template)
    template.each_char.with_index do |ch,i|
        unless i == template.length - 1
            @pairs[ch+template[i+1]] == nil ? @pairs[ch+template[i+1]] = 1 : @pairs[ch+template[i+1]] += 1
        end
    end
end

def do_it_all(num, template)
    init_pairs(template)
    num.times do 
        result = @pairs.dup
        @pairs.each do |pair|
            if result[pair[0]] > 0
                result[pair[0]] -= pair[1]
                insert_char = @code_hash[pair[0]]
                insert_pair_1 = pair[0][0] + insert_char
                insert_pair_2 = insert_char + pair[0][1]
                
                result[insert_pair_1] == nil ? result[insert_pair_1] = pair[1] : result[insert_pair_1] += pair[1]
                result[insert_pair_2] == nil ? result[insert_pair_2] = pair[1] : result[insert_pair_2] += pair[1]
            end
        end
        @pairs = result.dup
        result = []
    end

    count_hash = Hash.new

    @pairs.each do |x|
        count_hash[x[0][1]] == nil ? count_hash[x[0][1]] = x[1] : count_hash[x[0][1]] += x[1]
    end
    count_hash[template[0]] += 1 # Add the starting letter in the pairs

    return count_hash.values.max - count_hash.values.min
end

p "Part 1: " + do_it_all(10, "SVCHKVFKCSHVFNBKKPOC").to_s
puts
p "Part 2: " + do_it_all(40, "SVCHKVFKCSHVFNBKKPOC").to_s

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