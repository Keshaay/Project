
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

    p_7seg_decoder : process (bin, clear, dec, dec1) is
    begin

        if (clear = '1') then
            seg <= "1111111";  -- Clear the display
        else
        
            if(dec = '0') then
            case bin is

                when b"000000" =>
                    seg <= "0000001";

                when b"000001" =>
                    seg <= "1001111";

                when b"000010" =>
                    seg <= "0010010";

                when b"000011" =>
                    seg <= "0000110";

                when b"000100" =>
                    seg <= "1001100";

                when b"000101" =>
                    seg <= "0100100";

                when b"000110" =>
                    seg <= "0100000";

                when b"000111" =>
                    seg <= "0001111";

                when b"001000" =>
                    seg <= "0000000";

                when b"001001" =>
                    seg <= "0000100";

                when b"001010" =>
                    seg <= "0001000";

                when b"001011" =>
                    seg <= "1100000";

                when b"001100" =>
                    seg <= "0110001";

                when b"001101" =>
                    seg <= "1000010";

                when b"001110" =>
                    seg <= "0110000";

                when b"001111" =>
                    seg <= "0111000";

                when b"010000" =>
                    seg <= "0100001";

                when b"010001" =>
                    seg <= "1101000";

                when b"010010" =>
                    seg <= "0111011";

                when b"010011" =>
                    seg <= "0100111";

                when b"010100" =>
                    seg <= "0101000";

                when b"010101" =>
                    seg <= "1110001";

                when b"010111" =>
                    seg <= "0101010";

                when b"011000" =>
                    seg <= "1101010";

                when b"011001" =>
                    seg <= "1100010";

                when b"011010" =>
                    seg <= "0011000";

                when b"011011" =>
                    seg <= "0001100";

                when b"011100" =>
                    seg <= "1111010";

                when b"011101" =>
                    seg <= "0100101";

                when b"011110" =>
                    seg <= "1110000";

                when b"011111" =>
                    seg <= "1100011";

                when b"100000" =>
                    seg <= "1010101";

                when b"100001" =>
                    seg <= "1010100";

                when b"100010" =>
                    seg <= "1101011";

                when b"100011" =>
                    seg <= "1000100";

                when b"100100" =>
                    seg <= "0010011";
                    
                when others =>
                    seg <= "1111110";

            end case;

        else
            case bin is

                when b"001001" =>
                    seg <= "0000001";

                when b"001000" =>
                    seg <= "1001111";

                when b"000111" =>
                    seg <= "0010010";

                when b"000110" =>
                    seg <= "0000110";

                when b"000101" =>
                    seg <= "1001100";

                when b"000100" =>
                    seg <= "0100100";

                when b"000011" =>
                    seg <= "0100000";

                when b"000010" =>
                    seg <= "0001111";

                when b"000001" =>
                    seg <= "0000000";

                when b"000000" =>
                    seg <= "0000100";

                when b"100100" =>
                    seg <= "0001000";

                when b"100011" =>
                    seg <= "1100000";

                when b"100010" =>
                    seg <= "0110001";

                when b"100001" =>
                    seg <= "1000010";

                when b"100000" =>
                    seg <= "0110000";

                when b"011111" =>
                    seg <= "0111000";

                when b"011110" =>
                    seg <= "0100001";

                when b"011101" =>
                    seg <= "1101000";

                when b"011100" =>
                    seg <= "0111011";

                when b"011011" =>
                    seg <= "0100111";

                when b"011010" =>
                    seg <= "0101000";

                when b"011001" =>
                    seg <= "1110001";

                when b"011000" =>
                    seg <= "0101010";

                when b"010111" =>
                    seg <= "1101010";

                when b"010101" =>
                    seg <= "1100010";

                when b"010100" =>
                    seg <= "0011000";

                when b"010011" =>
                    seg <= "0001100";

                when b"010010" =>
                    seg <= "1111010";

                when b"010001" =>
                    seg <= "0100101";

                when b"010000" =>
                    seg <= "1110000";

                when b"001111" =>
                    seg <= "1100011";

                when b"001110" =>
                    seg <= "1010101";

                when b"001101" =>
                    seg <= "1010100";

                when b"001100" =>
                    seg <= "1101011";

                when b"001011" =>
                    seg <= "1000100";

                when b"001010" =>
                    seg <= "0010011";
                    
                when others =>
                    seg <= "1111110";
                end case;
            end if;
            
             if(dec1 = '1') then
            case bin is
    
                when b"000011" =>
                        seg <= "0000001";
    
                when b"000100" =>
                        seg <= "1001111";
    
                when b"000101" =>
                        seg <= "0010010";
    
                when b"000110" =>
                        seg <= "0000110";
    
                when b"000111" =>
                        seg <= "1001100";
    
                when b"001000" =>
                        seg <= "0100100";
    
                when b"001001" =>
                        seg <= "0100000";
    
                when b"000000" =>
                        seg <= "0001111";
    
                when b"000001" =>
                        seg <= "0000000";
    
                when b"000010" =>
                        seg <= "0000100";
    
                when b"001101" =>
                        seg <= "0001000";
    
                when b"001110" =>
                        seg <= "1100000";
    
                when b"001111" =>
                        seg <= "0110001";
    
                when b"010000" =>
                        seg <= "1000010";
    
                when b"010001" =>
                        seg <= "0110000";
    
                when b"010010" =>
                        seg <= "0111000";
    
                when b"010011" =>
                        seg <= "0100001";
    
                when b"010100" =>
                        seg <= "1101000";
    
                when b"010101" =>
                        seg <= "0111011";
    
                when b"010111" =>
                        seg <= "0100111";
    
                when b"011000" =>
                        seg <= "0101000";
    
                when b"011001" =>
                        seg <= "1110001";
    
                when b"011010" =>
                        seg <= "0101010";
    
                when b"011011" =>
                        seg <= "1101010";
    
                when b"011100" =>
                        seg <= "1100010";
    
                when b"011101" =>
                        seg <= "0011000";
    
                when b"011110" =>
                        seg <= "0001100";
    
                when b"011111" =>
                        seg <= "1111010";
    
                when b"100000" =>
                        seg <= "0100101";
    
                when b"100001" =>
                        seg <= "1110000";
    
                when b"100010" =>
                        seg <= "1100011";
    
                when b"100011" =>
                        seg <= "1010101";
    
                when b"100100" =>
                        seg <= "1010100";
    
                when b"001010" =>
                        seg <= "1101011";
    
                when b"001011" =>
                        seg <= "1000100";
    
                when b"001100" =>
                        seg <= "0010011";
                        
                when others =>
                        seg <= "1111110";
    
                end case;
                
            end if;

        end if;

    end process p_7seg_decoder;

end architecture behavioral;
