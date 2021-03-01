library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display is
	generic(horizontal_px : integer;
			vertical_px : integer);
	port( i_clk : in std_logic;
			x : in integer range 0 to 1500;
			y : in integer range 0 to 1500;
			red : out std_logic_vector(4 downto 0);
			green : out std_logic_vector(5 downto 0);
			blue : out std_logic_vector(4 downto 0));
end display;


architecture Behavioral of display is

signal drawPaddle : std_logic;


component paddle_ctrl is
generic(playerPaddle : integer
			);
port(i_clk : in std_logic;

		i_isActive : in std_logic;
		
		i_paddleUp : in std_logic;
		i_paddleDown : in std_logic;
		
		i_hight : in integer;
		i_width : in integer;
		
		i_HPOS : in integer;
		i_VPOS : in integer;
		
		o_drawPaddle : out std_logic
		);
end component paddle_ctrl;


begin

	C3 : paddle_ctrl GENERIC MAP(1) PORT MAP(i_clk, '0', '0', '0', 80, 30, x, y, drawPaddle);

	process(i_clk) is

	begin
	
		if (x < horizontal_px) and (y < vertical_px) then
			if (x = 0) or (x = (horizontal_px - 1)) or (y = 0) or (y = (vertical_px - 1)) then	-- biala ramka
				red	<=	"11111";
				green	<=	"111111";
				blue	<=	"11111";			
--			else
--				if (y < 200) then -- czerwony pasek na gorze
--					red	<=	"11111";
--					green	<=	"000000";
--					blue	<=	"00000";
--				elsif (y < 400) then -- zielony w srodku
--					red	<=	"00000";
--					green	<=	"111111";
--					blue	<=	"00000";
--				else -- niebieski na dole
--					red	<=	"00000";
--					green	<=	"000000";
--					blue	<=	"11111";
--				end if;			
			
			elsif (drawPaddle = '1') then
				red	<=	"00000";
				green	<=	"111111";
				blue	<=	"00000";
			else
				red	<=	"00000";
				green	<=	"000000";
				blue	<=	"00000";
			end if;
	
		end if;
	
--			IF((x > 200 AND x < 600) AND (y > 150 AND y < 450)) THEN	
--				red_s	<=	"11111";
--				green_s	<=	"111111";
--				blue_s	<=	"00000";
--			ELSE
--				red_s	<=	"00000";
--				green_s	<=	"000000";
--				blue_s	<=	"11111";
--			END IF;
--			
--			IF ((HPOS>800 AND HPOS<1040) OR (VPOS>600 AND VPOS<666)) THEN
--				red_s	<=	"00000";
--				green_s	<=	"000000";
--				blue_s	<=	"00000";
--			END IF;
--			


	end process;


end Behavioral;