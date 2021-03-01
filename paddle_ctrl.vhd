library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity paddle_ctrl is
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

end entity paddle_ctrl;


Architecture RTL of paddle_ctrl is

--current position
signal P_HPOS : INTEGER RANGE 0 TO 1500 := 40;
signal P_VPOS : INTEGER RANGE 0 TO 1500 := 40;

--size of paddle
--constant Paddle_hight: integer := 20;
--constant Paddle_width: integer := 10;

--size of board
signal H_size : INTEGER RANGE 0 TO 1500;
signal V_size : INTEGER RANGE 0 TO 1500;


begin

	draw : process(i_clk) is
	
		begin
		
			if rising_edge(i_clk) then
				if((i_HPOS >= P_HPOS) and (i_HPOS < (P_HPOS + i_width)) ) and 
					((i_VPOS >= P_VPOS)  and (i_VPOS < (P_VPOS + i_hight)) ) then
						
						o_drawPaddle <= '1';
				else
					o_drawPaddle <= '0';	
				end if;
			end if;
	end process;
	
	
	movement : process(i_clk) is
	
	begin
		if rising_edge(i_clk) then
			if i_isActive = '1' then
				if(i_paddleUp = '1') and ((P_HPOS + i_width) < V_size) then
					P_HPOS <= P_HPOS + 1;
				end if;
				
				if(i_paddleDown = '1') and (P_VPOS > 0) then
					P_VPOS <= P_VPOS - 1;
				end if;
			end if;
		end if;
		
	end process;






end Architecture RTL;