library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    Port (
        clk : in std_logic;             -- Hodinov� sign�l
        rst : in std_logic;             -- Reset sign�l
        input_str : in std_logic_vector(39 downto 0);  -- Vstupn� ?et?zec (5 znak? * 8 bit?)
        input_key : in std_logic_vector(39 downto 0);  -- Vstupn� kl�? pro Vernamovu �ifru
        mode_select : in std_logic_vector(1 downto 0); -- V�b?r �ifrovac� metody: 00-Vernam, 01-Atbash
        cipher_mode : in std_logic;    -- Re�im operace: '0' pro �ifrov�n�, '1' pro de�ifrov�n�
        led_r : out std_logic;          -- ?erven� LED
        led_g : out std_logic;          -- Zelen� LED
        led_b : out std_logic;          -- Modr� LED
        seg : out std_logic_vector(6 downto 0); -- Sedmisegmentov� displej
        SW: in std_logic_vector(1 downto 0);
        LED : out   std_logic_vector(1 downto 0);
        SW_L  : in    std_logic_vector(5 downto 0);
        LED_L : out   std_logic_vector(5 downto 0);
        
        
        CA    : out   std_logic;                    --! Cathode of segment A
        CB    : out   std_logic;                    --! Cathode of segment B
        CC    : out   std_logic;                    --! Cathode of segment C
        CD    : out   std_logic;                    --! Cathode of segment D
        CE    : out   std_logic;                    --! Cathode of segment E
        CF    : out   std_logic;                    --! Cathode of segment F
        CG    : out   std_logic;                    --! Cathode of segment G
        DP    : out   std_logic;                    --! Decimal point
        AN    : out   std_logic_vector(7 downto 0); --! Common anodes of all on-board displays
        BTNC  : in    std_logic;                    --! Clear the display
        BTND  : in    std_logic;
        BTNU  : in    std_logic;
        BTNR  : in    std_logic                     --! Switch between displays
    );
end top_level;

architecture Behavioral of top_level is
    signal encrypted : std_logic_vector(39 downto 0);
    signal decrypted : std_logic_vector(39 downto 0);


    -- Funkce pro Vernamovu �ifru
    function vernam_encrypt(input_str : std_logic_vector; key_str : std_logic_vector) return std_logic_vector is
        variable result : std_logic_vector(input_str'length-1 downto 0);
    begin
        for i in 0 to input_str'length/8-1 loop
            result(i*8+7 downto i*8) := input_str(i*8+7 downto i*8) xor key_str(i*8+7 downto i*8);
        end loop;
        return result;
    end function;

    -- Funkce pro Atbashovu �ifru
    function atbash_cipher(input : std_logic_vector) return std_logic_vector is
        variable result : std_logic_vector(input'length-1 downto 0);
        variable ch : character;
        variable pos : integer;
    begin
        for i in 0 to (input'length/8)-1 loop
            ch := character'val(to_integer(unsigned(input(i*8+7 downto i*8))));
            pos := character'pos(ch);
            if (pos >= character'pos('A') and pos <= character'pos('Z')) then
                ch := character'val(character'pos('Z') + character'pos('A') - pos);
            elsif (pos >= character'pos('a') and pos <= character'pos('z')) then
                ch := character'val(character'pos('z') + character'pos('a') - pos);
            end if;
            result(i*8+7 downto i*8) := std_logic_vector(to_unsigned(character'pos(ch), 8));
        end loop;
        return result;
    end function;
    
    component bin2seg is
        port (
            clear : in    std_logic;
            dec : in    std_logic;
            dec1 : in    std_logic;
            bin   : in    std_logic_vector(3 downto 0);
            seg   : out   std_logic_vector(6 downto 0)
        );
    end component;
    
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

    component simple_counter is
        generic (
            N_BITS : integer
        );
        port (
            clk   : in    std_logic;
            rst   : in    std_logic;
            en    : in    std_logic;
            count : out   std_logic_vector (2 downto 0)
        );
    end component;
    
    signal sig_tmp : std_logic_vector(3 downto 0);
    signal sig_en_250ms   : std_logic; 
    signal LED_activating_counter : std_logic_vector (2 downto 0);
    signal sig_event : std_logic;

begin
    -- LED stavov� sign�l
    -- P?i?azen� LED na z�klad? stavov�ho sign�lu

    clk_en0 : component clock_enable
        generic map (
            N_PERIODS => 25_000_000
        )
        port map (
            clk   => clk,
            rst   => BTNC,
            pulse => sig_en_250ms
        );

        display2 : component debounce
            port map (
                clk      => clk,
                rst      => BTNC,
                en       => sig_en_250ms,
                bouncey  => BTNR,
                clean    => led_B,
                pos_edge => sig_event,
                neg_edge => open
            );
            counter : component simple_counter
                generic map (
                    N_BITS => 3
                )
                port map (
                   clk   => clk,
                    rst   => BTNC,
                    en    => sig_event,
                    count => LED_activating_counter
                );



        display : component bin2seg
            port map (
                clear  => BTNC,
                bin    => sig_tmp,
                dec    => BTND,
                dec1   => BTNU,
                seg(6) => CA,
                seg(5) => CB,
                seg(4) => CC,
                seg(3) => CD,
                seg(2) => CE,
                seg(1) => CF,
                seg(0) => CG
            );

            sig_tmp <= SW_L;
            LED_L <= SW_L;
            DP <= '1';
    


    -- Stavov� automat pro �ifrov�n� a zobrazen�
 --   process(clk, rst)
 --   begin
 --       if rst = '1' then
 --           if SW(0)='1' then
 --           encrypted <= (others => '0');
 --           decrypted <= (others => '0');
 --           led_r <= '1';
 --           led_g <= '0';
 --           led_b <= '0';
 --           end if;
 --       elsif rising_edge(clk) then
 --           if SW(1)='1'then
 --            led_r <= '0';
 --           led_g <= '1';
 --           led_b <= '0';
 --           case mode_select is
 --               when "00" =>  -- Vernam Cipher
 --                   encrypted <= vernam_encrypt(input_str, input_key);
 --               when "01" =>  -- Atbash Cipher
 --                   encrypted <= atbash_cipher(input_str);
 --               when others =>
 --                   encrypted <= (others => '0');
 --           end case;
 --           if cipher_mode = '0' then
 --               decrypted <= encrypted;
 --           else
 --               decrypted <= input_str;
 --           end if;
 --           end if;
 --       end if;
 --   end process;

 
        process(LED_ACTIVATING_COUNTER)
        begin
        case LED_ACTIVATING_COUNTER is
        when "000" =>
        AN <="01111111";
        when "001" =>
        AN <="00111111";
        when "010" =>
        AN <="00011111";
        when "011" =>
        AN <="00001111";
        when "100" =>
        AN <="00000111";
        when "101" =>
        AN <="00000011";
        when "110" =>
        AN <="00000001";
        when "111" =>
        AN <="00000000";
        
        end case;
        end process;
    

end Behavioral;
