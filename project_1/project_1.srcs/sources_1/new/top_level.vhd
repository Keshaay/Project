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
    Port (  SW:in STD_LOGIC;
            BTNR : in STD_LOGIC;
            BTNL : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           UART_TXD : out STD_LOGIC);
end top_level;

architecture Behavioral of top_level is


constant txt : string := "Hello";
constant shift: integer :=5;
shared variable encrypted_ceasar:string(txt'range);
shared variable decrypted_ceasar:string(txt'range);
constant txt2 : string := "Melicharova"; -- Pùvodní zpráva
    constant key : string := "tukabelmaso"; -- Klíè musí být stejnì dlouhý jako zpráva
    shared variable encrypted_vernan: string(txt2'range);
    shared variable decrypted_vernan: string(txt2'range);
signal bits_encrypted_ceasar:std_logic_vector(8*txt'length-1 downto 0);
signal bits_decrypted_ceasar:std_logic_vector(8*txt'length-1 downto 0);
signal bits_encrypted_vernan:std_logic_vector(8*txt2'length-1 downto 0);
signal bits_decrypted_vernan:std_logic_vector(8*txt2'length-1 downto 0);



    
    -- Procedura pro šifrování Vernamovou šifrou
    procedure vernam_encrypt_decrypt(str: string; key: string; variable output: inout string) is
        variable tmp_char : character;
        variable str_byte, key_byte, result_byte : std_logic_vector(7 downto 0);
    begin
        for i in str'range loop
            -- Pøevod znak? na std_logic_vector
            str_byte := std_logic_vector(to_unsigned(character'pos(str(i)), 8));
            key_byte := std_logic_vector(to_unsigned(character'pos(key(i)), 8));
            -- Provádìní XOR operace
            result_byte := str_byte xor key_byte;
            -- Pøevod zp?t na character
            tmp_char := character'val(to_integer(unsigned(result_byte)));
            output(i) := tmp_char;
        end loop;
        report "Resulting text is :" & output;
    end procedure;



procedure ceasar_encrypt(str:string) is
 variable encrypted_char :character;
     variable tmp:integer;   
    begin
         for i in str'range loop
        tmp := character'pos(str(i))+shift;
        encrypted_char:=character'val(tmp);
        encrypted_ceasar(i):=encrypted_char;
     end loop;
    end procedure;

procedure ceasar_decrypt(str:string) is
 variable decrypted_char :character;
     variable tmp:integer;   
    begin
         for i in str'range loop
        tmp := character'pos(str(i))-shift;
        decrypted_char:=character'val(tmp);
        decrypted_ceasar(i):=decrypted_char;
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
            N_PERIODS : integer
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
signal sig_event1 : std_logic;
signal sig_event2 : std_logic;				--event for buttons

signal ltrindex_ceasar:natural:=0;			-- current letter index 
signal ltrindex_vernan:natural:=0;		
signal ltrindexMAX_ceasar:natural:=4;		-- max letter index can be changed for txt'length
signal ltrindexMAX_vernan:natural:=10;
signal uartRdy : std_logic;
signal uartSend : std_logic := '0';
signal uartData : std_logic_vector (7 downto 0):= "00000000";
signal uartTX : std_logic;
signal Data : std_logic_vector (7 downto 0);



begin

vernam_encrypt_decrypt(txt2, key, encrypted_vernan); -- Šifrování
vernam_encrypt_decrypt(encrypted_vernan, key, decrypted_vernan); -- Dešifrování
ceasar_encrypt(txt);
ceasar_decrypt(encrypted_ceasar);

bits_encrypted_ceasar<=to_std_logic_vector(encrypted_ceasar);
bits_decrypted_ceasar<=to_std_logic_vector(decrypted_ceasar);

bits_encrypted_vernan<=to_std_logic_vector(encrypted_vernan);
bits_decrypted_vernan<=to_std_logic_vector(decrypted_vernan);

    
clk_en : component clock_enable
        generic map (
            N_PERIODS => 200_000
        )
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            pulse => sig_en_2ms
        );
        
        debouncer : component debounce
        port map (
            clk      => CLK100MHZ,
            rst      => BTNC,
            en       => sig_en_2ms,
            bouncey  => BTNR,
            clean    => open,
            pos_edge => sig_event1,
            neg_edge => open
        );
        debouncel : component debounce
        port map (
            clk      => CLK100MHZ,
            rst      => BTNC,
            en       => sig_en_2ms,
            bouncey  => BTNL,
            clean    => open,
            pos_edge => sig_event2,
            neg_edge => open
        );
 
char_load_process : process (CLK100MHZ)
begin
	if (rising_edge(CLK100MHZ)) then
	if(SW='1') then
	   if (uartRdy='1' and (sig_event1='1'or sig_event2='1')) then
		  if (uartRdy='1' and sig_event1='1') then 
		   if(ltrindex_ceasar<ltrindexMAX_ceasar)then
			uartSend <= '1';
			Data<=bits_encrypted_ceasar(ltrindex_ceasar*8+7 downto 8*ltrindex_ceasar);				--logic for sending encrypted/decrypted letter for ceasar
			uartData <= Data;
			ltrindex_ceasar<=ltrindex_ceasar+1;
		  end if;
		  if(ltrindex_ceasar=ltrindexMAX_ceasar)then
			uartSend <= '1';
			Data<=bits_encrypted_ceasar(ltrindex_ceasar*8+7 downto 8*ltrindex_ceasar);
			uartData <= Data;
			ltrindex_ceasar<=0;
		      end if;
		  end if;
		  if (uartRdy='1' and sig_event2='1') then 
		  if(ltrindex_ceasar<ltrindexMAX_ceasar)then
			uartSend <= '1';
			Data<=bits_decrypted_ceasar(ltrindex_ceasar*8+7 downto 8*ltrindex_ceasar);
			uartData <= Data;
			ltrindex_ceasar<=ltrindex_ceasar+1;
		  end if;
		  if(ltrindex_ceasar=ltrindexMAX_ceasar)then
			uartSend <= '1';
			Data<=bits_decrypted_ceasar(ltrindex_ceasar*8+7 downto 8*ltrindex_ceasar);
			uartData <= Data;
			ltrindex_ceasar<=0;
		      end if;
		  end if;
		  else
		     uartSend<='0';
		end if;
		if(SW='0') then
	   if (uartRdy='1' and (sig_event1='1'or sig_event2='1')) then
		  if (uartRdy='1' and sig_event1='1') then 
		   if(ltrindex_vernan<ltrindexMAX_vernan)then
			uartSend <= '1';
			Data<=bits_encrypted_vernan(ltrindex_vernan*8+7 downto 8*ltrindex_vernan);
			uartData <= Data;
			ltrindex_vernan<=ltrindex_vernan+1;
		  end if;
		  if(ltrindex_vernan=ltrindexMAX_vernan)then
			uartSend <= '1';
			Data<=bits_encrypted_vernan(ltrindex_vernan*8+7 downto 8*ltrindex_vernan);
			uartData <= Data;
			ltrindex_vernan<=0;
		      end if;
		  end if;
		  if (uartRdy='1' and sig_event2='1') then 
		  if(ltrindex_vernan<ltrindexMAX_vernan)then
			uartSend <= '1';
			Data<=bits_decrypted_vernan(ltrindex_vernan*8+7 downto 8*ltrindex_vernan);
			uartData <= Data;
			ltrindex_vernan<=ltrindex_vernan+1;
		  end if;
		  if(ltrindex_vernan=ltrindexMAX_vernan)then
			uartSend <= '1';
			Data<=bits_decrypted_vernan(ltrindex_vernan*8+7 downto 8*ltrindex_vernan);
			uartData <= Data;
			ltrindex_vernan<=0;
		      end if;
		  end if;
		  else
		     uartSend<='0';
		end if;
		end if;
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
