----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 03/18/2024 06:48:27 PM
-- Design Name:
-- Module Name: top_level - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use std.standard.all;

use std.textio.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

library ieee;
    use ieee.std_logic_1164.all;

-------------------------------------------------

entity top_level is
    port (
        CLK100MHZ : in    STD_LOGIC;
        BTNC      : in    STD_LOGIC;
        SW        : in    STD_LOGIC_VECTOR(1 downto 0);
        BTNR      : in    STD_LOGIC;
        TX        : out   STD_LOGIC
    );
end entity top_level;

-------------------------------------------------

architecture behavioral of top_level is
    -- Component declaration for clock enable
    
constant txt : string := "Hello";
constant shift: integer :=5;
signal letter:integer:=0;
shared variable encrypted:string(txt'range);
shared variable decrypted:string(txt'range);
signal bits_encrypted_ceasar:std_logic_vector(8*txt'length-1 downto 0);
signal bits_decrypted_ceasar:std_logic_vector(8*txt'length-1 downto 0);
signal bits_encrypted_vernan:std_logic_vector(8*txt'length-1 downto 0);
signal bits_decrypted_vernan:std_logic_vector(8*txt'length-1 downto 0);
signal byte:std_logic_vector(7 downto 0);




procedure vernam_encrypt_decrypt(str: string; key: string; variable output: inout string) is
        variable tmp_char : character;
        variable str_byte, key_byte, result_byte : std_logic_vector(7 downto 0);
    begin
        for i in str'range loop
            -- P?evod znakù na std_logic_vector
            str_byte := std_logic_vector(to_unsigned(character'pos(str(i)), 8));
            key_byte := std_logic_vector(to_unsigned(character'pos(key(i)), 8));
            -- Provád?ní XOR operace
            result_byte := str_byte xor key_byte;
            -- P?evod zpìt na character
            tmp_char := character'val(to_integer(unsigned(result_byte)));
            output(i) := tmp_char;
        end loop;
    end procedure;

      
 procedure ceasar_encrypt(str:string) is
 variable encrypted_char :character;
     variable tmp:integer;   
    begin
         for i in str'range loop
        tmp := character'pos(str(i))+shift;
        encrypted_char:=character'val(tmp);
        encrypted(i):=encrypted_char;
     end loop;
    end procedure;

procedure ceasar_decrypt(str:string) is
 variable decrypted_char :character;
     variable tmp:integer;   
    begin
         for i in str'range loop
        tmp := character'pos(str(i))-shift;
        decrypted_char:=character'val(tmp);
        decrypted(i):=decrypted_char;
     end loop;
end procedure;

    function to_std_logic_vector(a : string) return std_logic_vector is
    variable ret : std_logic_vector(a'length*8-1 downto 0);
begin
    for i in a'range loop
        ret(i*8-1 downto i*8-8) := std_logic_vector(to_unsigned(character'pos(a(i)), 8));
    end loop;
    return ret;
end function to_std_logic_vector;
    
    component clock_enable is
        generic (
            PERIOD : integer
        );
        port (
            clk   : in    std_logic;
            rst   : in    std_logic;
            pulse : out   std_logic
        );
    end component;

    -- Component declaration for button debouncer
    component debounce is
        port (
            clk      : in    std_logic;
            rst      : in    std_logic;
            en       : in    std_logic;
            bouncey  : in    std_logic;
            clean    : out   std_logic;
            pos_edge : out   std_logic;
            neg_edge : out   std_logic
        );
    end component;

    -- Component declaration for serial tx
    component serial_tx is
        port (
            clk     : in    STD_LOGIC;
            rst     : in    STD_LOGIC;
            data    : in    STD_LOGIC_VECTOR(7 downto 0);
            trigger : in    STD_LOGIC;
            tx      : out   STD_LOGIC
        );
    end component;

    -- Local signals
    --! Clock enable signal for debouncer
    signal sig_en_2ms : std_logic;
    --! Edge-driven signal that lasts for only one clock cycle
    signal sig_event : std_logic;
     signal data_serialTX : std_logic_vector (7 downto 0);
begin



bits_decrypted_ceasar <=to_std_logic_vector(decrypted);             -- bity pro Ceasara
bits_encrypted_ceasar <=to_std_logic_vector(encrypted);             -- bity pro Ceasara

ceasar_decrypt(encrypted);                                  --šifry
ceasar_encrypt(txt);

    -- Component instantiation of clock enable for 2 ms
    button_en : component clock_enable
        generic map (
            PERIOD => 200_000
        )
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            pulse => sig_en_2ms
        );

    -- Component instantiation of button debouncer
    button : component debounce
        port map (
            clk      => CLK100MHZ,
            rst      => BTNC,
            en       => sig_en_2ms,
            bouncey  => BTNR,
            clean    => open,
            pos_edge => sig_event,
            neg_edge => open
        );

    -- Component instantiation of serial tx
    serial : component serial_tx
        port map (
            clk     => CLK100MHZ,
            rst     => BTNC,
            data    => data_serialTX,
            trigger => sig_event,
            tx      => TX
        );

crypt_decrypt: process(CLK100MHZ)
 begin
        if (rising_edge(CLK100MHZ)) then
            
            case SW is
                when "00" =>
                    if (letter < 4 )then
                         byte <=bits_encrypted_ceasar (letter*8+7 downto letter*8);                         -- ceasar a encrypce
                         data_serialTX <= byte;
                         letter <= letter +1;        
                    end if;
                    if (letter = 4 )then
                    byte <=bits_encrypted_ceasar (letter*8+7 downto letter*8);                         
                         data_serialTX <= byte;
                         letter <= 0;
                    end if;
                when "01" =>                            -- ceasar a decrypce
                    if (letter < 4 )then
                         byte <=bits_decrypted_ceasar (letter*8+7 downto letter*8);                         -- ceasar a encrypce
                         data_serialTX <= byte;
                         letter <= letter +1;        
                    end if;
                    if (letter = 4 )then
                    byte <=bits_decrypted_ceasar (letter*8+7 downto letter*8);                         
                         data_serialTX <= byte;
                         letter <= 0;
                    end if;
            --    when "10" =>                                            -- vernan a encrypce
                  --  if (letter < 4 )then
                    --     byte <=bits_encrypted_vernan (letter*8+7 downto letter*8);                         
                     --    data_serialTX <= byte;
                    --     letter <= letter +1;        
               --     end if;
                --    if (letter = 4 )then
                 --   byte <=bits_encrypted_vernan (letter*8+7 downto letter*8);                         
                   --      data_serialTX <= byte;
                   --      letter <= 0;
              --      end if;
--                when "11" =>        
--                    if (letter < 4 )then
                     --    byte <=bits_encrypted_vernan (letter*8+7 downto letter*8);                         
                     --    data_serialTX <= byte;
                       --  letter <= letter +1;        
--                    end if;
--                    if (letter = 4 )then
                  --  byte <=bits_encrypted_vernan (letter*8+7 downto letter*8);                         
                    --     data_serialTX <= byte;
                    --     letter <= 0;
--                    end if;                                 -- vernan a decrypce
                 when others =>   
                    data_serialTX <= "00000000";
            end case;
        end if;
end process crypt_decrypt;

end architecture behavioral;