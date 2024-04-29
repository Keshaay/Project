----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2024 15:49:11
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( BTNR : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           UART_TXD : out STD_LOGIC);
end top_level;

architecture Behavioral of top_level is


constant txt : string := "Hello";
constant shift: integer :=5;
shared variable encrypted:string(txt'range);
shared variable decrypted:string(txt'range);
signal bits_encrypted_ceasar:std_logic_vector(8*txt'length-1 downto 0);
signal bits_decrypted_ceasar:std_logic_vector(8*txt'length-1 downto 0);
signal bits_encrypted_vernan:std_logic_vector(8*txt'length-1 downto 0);
signal bits_decrypted_vernan:std_logic_vector(8*txt'length-1 downto 0);


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


component UART_TX_CTRL
Port(
	SEND : in std_logic;
	DATA : in std_logic_vector(7 downto 0);
	CLK : in std_logic;          
	READY : out std_logic;
	UART_TX : out std_logic
	);
end component;


signal sig_en_2ms : std_logic;
    signal sig_event : std_logic;

signal uartRdy : std_logic;
signal uartSend : std_logic := '0';
signal uartData : std_logic_vector (7 downto 0):= "00000000";
signal uartTX : std_logic;
signal Data : std_logic_vector (7 downto 0):= "01000100";



begin

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


char_load_process : process (CLK100MHZ)
begin
	if (rising_edge(CLK100MHZ)) then
		if (uartRdy='1' and BTNR='1') then
			uartSend <= '1';
			uartData <= Data;
		else
			uartSend <= '0';
		end if;
	end if;
end process;

--Component used to send a byte of data over a UART line.
Inst_UART_TX_CTRL: UART_TX_CTRL port map(
		SEND => uartSend,
		DATA => uartData,
		CLK => CLK100MHZ,
		READY => uartRdy,
		UART_TX => uartTX 
	);

UART_TXD <= uartTX;

end Behavioral;
