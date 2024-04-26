library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use std.env.all;
use std.standard.all;
use std.textio.all;

entity tb_vernam is
end tb_vernam;

architecture Behavioral of tb_vernam is
    constant txt : string := "Melicharova"; -- P?vodn� zpr�va
    constant key : string := "tukabelmaso"; -- Kl�? mus� b�t stejn? dlouh� jako zpr�va
    shared variable encrypted: string(txt'range);
    shared variable decrypted: string(txt'range);
    
    -- Procedura pro �ifrov�n� Vernamovou �ifrou
    procedure vernam_encrypt_decrypt(str: string; key: string; variable output: inout string) is
        variable tmp_char : character;
        variable str_byte, key_byte, result_byte : std_logic_vector(7 downto 0);
    begin
        for i in str'range loop
            -- P?evod znak� na std_logic_vector
            str_byte := std_logic_vector(to_unsigned(character'pos(str(i)), 8));
            key_byte := std_logic_vector(to_unsigned(character'pos(key(i)), 8));
            -- Prov�d?n� XOR operace
            result_byte := str_byte xor key_byte;
            -- P?evod zp�t na character
            tmp_char := character'val(to_integer(unsigned(result_byte)));
            output(i) := tmp_char;
        end loop;
        report "Resulting text is :" & output;
    end procedure;

begin
    -- Zavol�me proceduru pro �ifrov�n� a de�ifrov�n�
    vernam_encrypt_decrypt(txt, key, encrypted); -- �ifrov�n�
    vernam_encrypt_decrypt(encrypted, key, decrypted); -- De�ifrov�n�
end Behavioral;