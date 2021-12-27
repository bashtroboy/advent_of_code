transmission = DATA.read    # Hex transmission as its received
@bits = ""                   # the transmission converted to binary
@versions = []               # record all @versions in transmission
@packets = []

# convert Hex transmission to binary
transmission.each_char do |ch|
    # convert hex to binary, and ensure digits are four in length with padding
    @bits += ch.to_i(16).to_s(2).rjust(4,"0")
end
3.times do
    version = 0
    type = 0

    version = @bits[0..2].to_i(2)
    type = @bits[3..5].to_i(2)

    @versions << version
    puts "version=#{version}, type=#{type}"

    @bits.slice!(0..5)
    if type == 4 
        last_char = false
        literal = ""
        
        while last_char == false do
            @bits[0] == "0" ? last_char = true : nil
            literal += @bits[0..4]
            @bits.slice!(0..4)
        end

        @packets << [version, type, literal]
        # trim remaining zeroes
        while @bits[0] == "0" do
            @bits.slice!(0)
        end
    else
        if @bits[0] == 0
            @bits.slice!(0)
            sub_length = @bits[0..14].to_i(2)
            @bits.slice!(0..14)
            @packets << [version, type, 0, sub_length]
        else
            @bits.slice!(0)
            sub_num = @bits[0..10].to_i(2)
            @bits.slice!(0..10)
            @packets << [version, type, 1, sub_num]
        end
    end
end

p @bits
puts
p @packets

__END__
620080001611562C8802118E34