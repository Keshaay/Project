

library ieee;
    use ieee.std_logic_1164.all;

-------------------------------------------------

entity bin2seg is
    port (
        clear : in    std_logic;  
        dec : in    std_logic;
        dec1 : in    std_logic;
        bin   : in    std_logic_vector(5 downto 0); --! Binary representation of one hexadecimal symbol
        seg   : out   std_logic_vector(6 downto 0)  --! Seven active-low segments from A to G
    );
end entity bin2seg;

-------------------------------------------------

architecture behavioral of bin2seg is
begin

    p_7seg_decoder : process (bin, clear) is
    begin

        if (clear = '1') then
            seg <= "1111111";  -- Clear the display
        else

            if(dec1 = '1') then
            case bin is
    
                when x"3" =>
                        seg <= "0000001";
    
                when x"4" =>
                        seg <= "1001111";
    
                when x"5" =>
                        seg <= "0010010";
    
                when x"6" =>
                        seg <= "0000110";
    
                when x"7" =>
                        seg <= "1001100";
    
                when x"8" =>
                        seg <= "0100100";
    
                when x"9" =>
                        seg <= "0100000";
    
                when x"0" =>
                        seg <= "0001111";
    
                when x"1" =>
                        seg <= "0000000";
    
                when x"2" =>
                        seg <= "0000100";
    
                when x"d" =>
                        seg <= "0001000";
    
                when x"E" =>
                        seg <= "1100000";
    
                when x"F" =>
                        seg <= "0110001";
    
                when x"G" =>
                        seg <= "1000010";
    
                when x"h" =>
                        seg <= "0110000";
    
                when x"i" =>
                        seg <= "0111000";
    
                when x"j" =>
                        seg <= "0100001";
    
                when x"k" =>
                        seg <= "1101000";
    
                when x"L" =>
                        seg <= "0111011";
    
                when x"M" =>
                        seg <= "0100111";
    
                when x"n" =>
                        seg <= "0101000";
    
                when x"o" =>
                        seg <= "1110001";
    
                when x"P" =>
                        seg <= "0101010";
    
                when x"q" =>
                        seg <= "1101010";
    
                when x"r" =>
                        seg <= "1100010";
    
                when x"S" =>
                        seg <= "0011000";
    
                when x"t" =>
                        seg <= "0001100";
    
                when x"U" =>
                        seg <= "1111010";
    
                when x"V" =>
                        seg <= "0100101";
    
                when x"W" =>
                        seg <= "1110000";
    
                when x"x" =>
                        seg <= "1100011";
    
                when x"y" =>
                        seg <= "1010101";
    
                when x"z" =>
                        seg <= "1010100";
    
                when x"a" =>
                        seg <= "1101011";
    
                when x"b" =>
                        seg <= "1000100";
    
                when x"c" =>
                        seg <= "0010011";
                        
                when others =>
                        seg <= "1111110";
    
                end case;
    

            if(dec = '0') then
            case bin is

                when x"0" =>
                    seg <= "0000001";

                when x"1" =>
                    seg <= "1001111";

                when x"2" =>
                    seg <= "0010010";

                when x"3" =>
                    seg <= "0000110";

                when x"4" =>
                    seg <= "1001100";

                when x"5" =>
                    seg <= "0100100";

                when x"6" =>
                    seg <= "0100000";

                when x"7" =>
                    seg <= "0001111";

                when x"8" =>
                    seg <= "0000000";

                when x"9" =>
                    seg <= "0000100";

                when x"A" =>
                    seg <= "0001000";

                when x"b" =>
                    seg <= "1100000";

                when x"C" =>
                    seg <= "0110001";

                when x"d" =>
                    seg <= "1000010";

                when x"E" =>
                    seg <= "0110000";

                when x"F" =>
                    seg <= "0111000";

                when x"G" =>
                    seg <= "0100001";

                when x"h" =>
                    seg <= "1101000";

                when x"i" =>
                    seg <= "0111011";

                when x"j" =>
                    seg <= "0100111";

                when x"k" =>
                    seg <= "0101000";

                when x"L" =>
                    seg <= "1110001";

                when x"M" =>
                    seg <= "0101010";

                when x"n" =>
                    seg <= "1101010";

                when x"o" =>
                    seg <= "1100010";

                when x"P" =>
                    seg <= "0011000";

                when x"q" =>
                    seg <= "0001100";

                when x"r" =>
                    seg <= "1111010";

                when x"S" =>
                    seg <= "0100101";

                when x"t" =>
                    seg <= "1110000";

                when x"U" =>
                    seg <= "1100011";

                when x"V" =>
                    seg <= "1010101";

                when x"W" =>
                    seg <= "1010100";

                when x"x" =>
                    seg <= "1101011";

                when x"y" =>
                    seg <= "1000100";

                when x"Z" =>
                    seg <= "0010011";
                    
                when others =>
                    seg <= "1111110";

            end case;

        else
            case bin is

                when x"9" =>
                    seg <= "0000001";

                when x"8" =>
                    seg <= "1001111";

                when x"7" =>
                    seg <= "0010010";

                when x"6" =>
                    seg <= "0000110";

                when x"5" =>
                    seg <= "1001100";

                when x"4" =>
                    seg <= "0100100";

                when x"3" =>
                    seg <= "0100000";

                when x"2" =>
                    seg <= "0001111";

                when x"1" =>
                    seg <= "0000000";

                when x"0" =>
                    seg <= "0000100";

                when x"z" =>
                    seg <= "0001000";

                when x"y" =>
                    seg <= "1100000";

                when x"x" =>
                    seg <= "0110001";

                when x"w" =>
                    seg <= "1000010";

                when x"v" =>
                    seg <= "0110000";

                when x"u" =>
                    seg <= "0111000";

                when x"t" =>
                    seg <= "0100001";

                when x"s" =>
                    seg <= "1101000";

                when x"r" =>
                    seg <= "0111011";

                when x"q" =>
                    seg <= "0100111";

                when x"p" =>
                    seg <= "0101000";

                when x"o" =>
                    seg <= "1110001";

                when x"n" =>
                    seg <= "0101010";

                when x"m" =>
                    seg <= "1101010";

                when x"l" =>
                    seg <= "1100010";

                when x"k" =>
                    seg <= "0011000";

                when x"j" =>
                    seg <= "0001100";

                when x"i" =>
                    seg <= "1111010";

                when x"h" =>
                    seg <= "0100101";

                when x"g" =>
                    seg <= "1110000";

                when x"f" =>
                    seg <= "1100011";

                when x"e" =>
                    seg <= "1010101";

                when x"d" =>
                    seg <= "1010100";

                when x"c" =>
                    seg <= "1101011";

                when x"b" =>
                    seg <= "1000100";

                when x"a" =>
                    seg <= "0010011";
                    
                when others =>
                    seg <= "1111110";
                end case;
            end if;

        end if;

    end process p_7seg_decoder;

end architecture behavioral;
