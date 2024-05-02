library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use std.env.all;
use std.standard.all;
use std.textio.all;

entity tb_vernam is
end tb_vernam;

architecture Behavioral of tb_vernam is
    constant txt : string := "Melicharova"; -- Pùvodní zpráva
    constant key : string := "tukabelmaso"; -- Klíè musí být stejnì dlouhý jako zpráva
    shared variable encrypted: string(txt'range);
    shared variable decrypted: string(txt'range);
    
    -- Procedura pro šifrování Vernamovou šifrou
    procedure vernam_encrypt_decrypt(str: string; key: string; variable output: inout string) is
        variable tmp_char : character;
        variable str_byte, key_byte, result_byte : std_logic_vector(7 downto 0);
    begin
        for i in str'range loop
            -- Pøevod znaků na std_logic_vector
            str_byte := std_logic_vector(to_unsigned(character'pos(str(i)), 8));
            key_byte := std_logic_vector(to_unsigned(character'pos(key(i)), 8));
            -- Provádìní XOR operace
            result_byte := str_byte xor key_byte;
            -- Pøevod zpět na character
            tmp_char := character'val(to_integer(unsigned(result_byte)));
            output(i) := tmp_char;
        end loop;
        report "Resulting text is :" & output;
    end procedure;

begin
    -- Zavoláme proceduru pro šifrování a dešifrování
    vernam_encrypt_decrypt(txt, key, encrypted); -- Šifrování
    vernam_encrypt_decrypt(encrypted, txt, decrypted); -- Dešifrování
end Behavioral;
