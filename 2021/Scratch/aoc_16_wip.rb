#!/usr/bin/env ruby

input = DATA.read

class Packet 
    class LiteralPacket < Packet
        attr_reader :value

        def initialize(version, value)
            @version = version
            @value = value
        end

        def version_sum
            @version
        end
    end

    class OperatorPacket < Packet
        class << self
            attr_accessor :operator

            def class_for_op(&block)
                klass = Class.new(OperatorPacket)
                klass.operator = block
                klass
            end

            def class_type(type)
                case type
                when 0
                  SumPacket
                when 1
                  ProductPacket
                when 2
                  MinPacket
                when 3
                  MaxPacket
                when 5
                  GreaterThanPacket
                when 6
                  LessThanPacket
                when 7
                  EqualsPacket
                end
            end
        end

        SumPacket = class_for_op { |values| values.sum }
        ProductPacket = class_for_op { |values| values.inject(&:*) }
        MinPacket = class_for_op { |values| values.min }
        MaxPacket = class_for_op { |values| values.max }
        GreaterThanPacket = class_for_op { |values| values.inject(&:>) ? 1 : 0 }
        LessThanPacket = class_for_op { |values| values.inject(&:<) ? 1 : 0 }
        EqualsPacket = class_for_op { |values| values.inject(&:==) ? 1 : 0 }

        def initialize(version, packets)
            @version = version
            @packets = packets
        end

        def value
            self.class.operator.call(@packets.map(&:value))
        end

        def version_sum
            @version + @packets.map(&:version_sum).sum
          end
        end
    
        class << self
          def parse(bits)
            version = bits.shift(3).join.to_i(2)
            type = bits.shift(3).join.to_i(2)
            if type == 4
              value = parse_literal(bits)
              LiteralPacket.new(version, value)
            else
              length_type, length = parse_length(bits)
              sub_packets = parse_sub_packets(bits, length_type, length)
              OperatorPacket.class_type(type).new(version, sub_packets)
            end
          end
    
          def parse_literal(bits)
            parse_literal_arr(bits).join.to_i(2)
          end
    
          def parse_literal_arr(bits)
            continue, *group = bits.shift(5)
            return group if continue.zero?
            group + parse_literal_arr(bits)
          end
    
          def parse_length(bits)
            length_type = bits.shift(1).first
            length = if length_type == 0
              bits.shift(15).join.to_i(2)
            else
              bits.shift(11).join.to_i(2)
            end
            [length_type, length]
          end
    
          def parse_sub_packets(bits, length_type, length)
            packets = []
            case length_type
            when 0
              sub_bits = bits.shift(length)
              until sub_bits.empty? do
                packets << parse(sub_bits)
              end
            when 1
              length.times { packets << parse(bits) }
            end
            packets
          end
        end
      end


    
      def part_1
        @packet.version_sum
      end
    
      def part_2
        @packet.value
      end

      @packet = Packet.parse(input.to_i(16).digits(2).reverse)
      #part_1



__END__
420D5A802122FD25C8CD7CC010B00564D0E4B76C7D5A59C8C014E007325F116C958F2C7D31EB4EDF90A9803B2EB5340924CA002761803317E2B4793006E28C2286440087C5682312D0024B9EF464DF37EFA0CD031802FA00B4B7ED2D6BD2109485E3F3791FDEB3AF0D8802A899E49370012A926A9F8193801531C84F5F573004F803571006A2C46B8280008645C8B91924AD3753002E512400CC170038400A002BCD80A445002440082021DD807C0201C510066670035C00940125D803E170030400B7003C0018660034E6F1801201042575880A5004D9372A520E735C876FD2C3008274D24CDE614A68626D94804D4929693F003531006A1A47C85000084C4586B10D802F5977E88D2DD2898D6F17A614CC0109E9CE97D02D006EC00086C648591740010C8AF14E0E180253673400AA48D15E468A2000ADCCED1A174218D6C017DCFAA4EB2C8C5FA7F21D3F9152012F6C01797FF3B4AE38C32FFE7695C719A6AB5E25080250EE7BB7FEF72E13980553CE932EB26C72A2D26372D69759CC014F005E7E9F4E9FA7D3653FCC879803E200CC678470EC0010E82B11E34080330D211C663004F00101911791179296E7F869F9C017998EF11A1BCA52989F5EA778866008D8023255DFBB7BD2A552B65A98ECFEC51D540209DFF2FF2B9C1B9FE5D6A469F81590079160094CD73D85FD2699C5C9DCF21F0700094A1AC9EDA64AE3D37D34200B7B401596D678A73AFB2D0B1B88057230A42B2BD88E7F9F0C94F1ECB7B0DD393489182F9802D3F875C00DC40010F8911C61F8002111BA1FC2E400BEA5AA0334F9359EA741892D81100B83337BD2DDB4E43B401A800021F19A09C1F1006229C3F8726009E002A12D71B96B8E49BB180273AA722468002CC7B818C01B04F77B39EFDF53973D95ADB5CD921802980199CF4ADAA7B67B3D9ACFBEC4F82D19A4F75DE78002007CD6D1A24455200A0E5C47801559BF58665D80