library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity atbash_cipher is
    Port ( input_str : in string(1 to 5);
           output_str : out string(1 to 5)
         );
end atbash_cipher;

architecture Behavioral of atbash_cipher is
begin

    -- Atbash cipher encryption/decryption process
    process(input_str)
    begin
        for i in input_str'range loop
            if input_str(i) >= 'A' and input_str(i) <= 'Z' then
                -- Compute Atbash cipher for uppercase letters
                output_str(i) <= character'val(character'pos('Z') + character'pos('A') - character'pos(input_str(i)));
            else
                -- Copy non-alphabetic characters unchanged
                output_str(i) <= input_str(i);
            end if;
        end loop;
    end process;

end Behavioral;
