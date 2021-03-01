library ieee;
use ieee.std_logic_1164.all;


entity debounce_btn is
port(i_clk : in std_logic;
		i_sw : in std_logic;
		o_sw : out std_logic);

end entity debounce_btn;

Architecture RTL of debounce_btn is

  -- (10 ms)
  constant c_DEBOUNCE_LIMIT : integer := 500000;
  
  signal r_Count : integer range 0 to c_DEBOUNCE_LIMIT := 0;
  signal r_State : std_logic := '0';


begin

	debouncer : process(i_clk) is
	
	begin
		if rising_edge(i_clk) then
			if (i_sw /= r_State and r_Count < c_DEBOUNCE_LIMIT) then
				r_Count <= r_Count + 1;
			elsif r_Count = c_DEBOUNCE_LIMIT then
				r_State <= i_sw;
				r_Count <= 0;
			else
				r_Count <= 0;
			end if;
	end if;
	
	end process debouncer;
	
	o_sw <= r_State;
	
end Architecture RTL;