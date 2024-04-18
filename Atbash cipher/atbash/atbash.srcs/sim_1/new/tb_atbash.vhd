library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use std.env.all;
use std.standard.all;
use std.textio.all;

entity test_tb is
end test_tb;

architecture Behavioral of test_tb is
    constant txt : string := "Melicharova"; -- Input text, mixed case
    shared variable encrypted: string(txt'range);
    shared variable decrypted: string(txt'range);

    -- Procedure to perform Atbash cipher encryption/decryption
    procedure atbash_cipher(str: in string; result: inout string) is
        variable ciphered_char : character;
        variable tmp: integer;
    begin
        for i in str'range loop
            if str(i) >= 'A' and str(i) <= 'Z' then
                tmp := character'pos('Z') + character'pos('A') - character'pos(str(i));
                ciphered_char := character'val(tmp);
            elsif str(i) >= 'a' and str(i) <= 'z' then
                tmp := character'pos('z') + character'pos('a') - character'pos(str(i));
                ciphered_char := character'val(tmp);
            else
                ciphered_char := str(i); -- Non-alphabet characters are copied as-is
            end if;
            result(i) := ciphered_char; -- Store ciphered character into the result
        end loop;
    end procedure;

begin
    -- Main test process
    process
    begin
        atbash_cipher(txt, encrypted); -- Encrypt the text
        atbash_cipher(encrypted, decrypted); -- Decrypt the text

        report "Original text: " & txt;
        report "Encrypted text: " & encrypted;
        report "Decrypted text: " & decrypted;

        wait; -- Wait statement to halt the simulation
    end process;

end Behavioral;
