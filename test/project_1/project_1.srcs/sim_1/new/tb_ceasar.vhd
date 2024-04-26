library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use std.env.all;
use std.standard.all;

use std.textio.all;


entity tb_ceasar is
end tb_ceasar;

architecture Behavioral of tb_ceasar is




constant txt : string := "Hello";
constant shift: integer :=5;
shared variable encrypted:string(txt'range);
shared variable decrypted:string(txt'range);
signal bits_encrypted:std_logic_vector(8*txt'length-1 downto 0);
signal bits_decrypted:std_logic_vector(8*txt'length-1 downto 0);
signal letter_nmb1:integer:=0;
signal letter_nmb2:integer:=1;
signal letter_nmb3:integer:=2;
signal letter_nmb4:integer:=3;
signal letter_nmb5:integer:=4;
signal byte1:std_logic_vector(7 downto 0);
signal byte2:std_logic_vector(7 downto 0);
signal byte3:std_logic_vector(7 downto 0);
signal byte4:std_logic_vector(7 downto 0);
signal byte5:std_logic_vector(7 downto 0);

signal byte6:std_logic_vector(7 downto 0);
signal byte7:std_logic_vector(7 downto 0);
signal byte8:std_logic_vector(7 downto 0);
signal byte9:std_logic_vector(7 downto 0);
signal byte10:std_logic_vector(7 downto 0);



procedure ceasar_encrypt(str:string) is
 variable encrypted_char :character;
     variable tmp:integer;   
    begin

         for i in str'range loop
        tmp := character'pos(str(i))+shift;
        encrypted_char:=character'val(tmp);
       -- report character'image(encrypted_char);
        encrypted(i):=encrypted_char;
     end loop;
    report "Encrypted text is :" & encrypted;
    end procedure;





procedure ceasar_decrypt(str:string) is
 variable decrypted_char :character;
     variable tmp:integer;   
    begin

         for i in str'range loop
        tmp := character'pos(str(i))-shift;
        decrypted_char:=character'val(tmp);
       -- report character'image(decrypted_char);
        decrypted(i):=decrypted_char;
     end loop;
    report "Decrypted text is :" & decrypted;
end procedure;


function to_std_logic_vector(a : string) return std_logic_vector is
    variable ret : std_logic_vector(a'length*8-1 downto 0);
begin
    for i in a'range loop
        ret(i*8-1 downto i*8-8) := std_logic_vector(to_unsigned(character'pos(a(i)), 8));
    end loop;
    return ret;
end function to_std_logic_vector;





begin


byte1<=bits_encrypted(letter_nmb1*8+7 downto letter_nmb1*8);
byte2<=bits_encrypted(letter_nmb2*8+7 downto letter_nmb2*8);
byte3<=bits_encrypted(letter_nmb3*8+7 downto letter_nmb3*8);
byte4<=bits_encrypted(letter_nmb4*8+7 downto letter_nmb4*8);
byte5<=bits_encrypted(letter_nmb5*8+7 downto letter_nmb5*8);

byte6<=bits_decrypted(letter_nmb1*8+7 downto letter_nmb1*8);
byte7<=bits_decrypted(letter_nmb2*8+7 downto letter_nmb2*8);
byte8<=bits_decrypted(letter_nmb3*8+7 downto letter_nmb3*8);
byte9<=bits_decrypted(letter_nmb4*8+7 downto letter_nmb4*8);
byte10<=bits_decrypted(letter_nmb5*8+7 downto letter_nmb5*8);

bits_decrypted <=to_std_logic_vector(decrypted);
bits_encrypted <=to_std_logic_vector(encrypted);

ceasar_decrypt(encrypted);
ceasar_encrypt(txt);



end Behavioral;