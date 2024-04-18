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





begin



 ceasar_decrypt(encrypted);
 ceasar_encrypt(txt);



end Behavioral;
