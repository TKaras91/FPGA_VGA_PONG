library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sync is
	generic(horizontal_px : integer;
			 vertical_px : integer;
			 H_Front_Porch : integer;
			 H_Sync_Pulse : integer;
			 H_Back_Porch : integer;
			 V_Front_Porch : integer;
			 V_Sync_Pulse : integer;
			 V_Back_Porch : integer);
	port(i_clk : in std_logic;
		o_HPOS : out INTEGER RANGE 0 TO 1500;
		o_VPOS : out INTEGER RANGE 0 TO 1500;
		hsync : out std_logic;
		vsync : out std_logic);
end sync;


architecture Behavioral of sync is

SIGNAL HPOS: INTEGER RANGE 0 TO 1500 :=0;
SIGNAL VPOS: INTEGER RANGE 0 TO 1500 :=0;


begin

	sync:process(i_clk) is
	
	begin
		if rising_edge(i_clk) then
		
			IF (HPOS<(horizontal_px + H_Front_Porch + H_Sync_Pulse + H_Back_Porch)) THEN
				HPOS<=HPOS+1;
			ELSE
				HPOS<=0;
				IF (VPOS<(vertical_px + V_Front_Porch + V_Sync_Pulse + V_Back_Porch)) THEN
					VPOS<=VPOS+1;
				ELSE
					VPOS<=0;
				END IF;
			END IF;
			

			if (HPOS > (horizontal_px + H_Front_Porch)) and (HPOS < (horizontal_px + H_Front_Porch + H_Sync_Pulse)) then
				hsync <= '0';
			else
				hsync <= '1';
			end if;
			
			if (VPOS > (vertical_px + V_Front_Porch)) and (VPOS < (vertical_px + V_Front_Porch + V_Sync_Pulse)) then
				vsync <= '0';
			else
				vsync <= '1';
			end if;


		end if;
		
		
	end process;
	
	

	o_HPOS <= HPOS;
	o_VPOS <= VPOS;
	

	
	
end Behavioral;