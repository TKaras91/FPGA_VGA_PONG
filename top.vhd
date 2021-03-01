library ieee;
use ieee.std_logic_1164.all;


entity top is
	port(
	-- Main clock
	i_clk_50 : in std_logic;
	
	-- Uart RX
	--i_uart_rx : in std_logic;
	
	-- buttons
	i_sw_1 : in std_logic;
	i_sw_2 : in std_logic;
	i_sw_3 : in std_logic;
	i_sw_4 : in std_logic;
	
	-- VGA
	o_hsync : out std_logic;
	o_vsync : out std_logic;
	o_red : out std_logic_vector(4 downto 0);
	o_green : out std_logic_vector(5 downto 0);
	o_blue : out std_logic_vector(4 downto 0));
	
end entity top;

Architecture RTL of top is

	constant horizontal_px : integer := 800;
	constant vertical_px : integer := 600;
	
	
	constant H_Front_Porch : integer := 56;
	constant H_Sync_Pulse  : integer := 120;
	constant H_Back_Porch  : integer := 64;

	constant V_Front_Porch : integer := 37;
	constant V_Sync_Pulse  : integer := 6;
	constant V_Back_Porch  : integer := 23;
	
	signal HPOS : INTEGER RANGE 0 TO 1500;
	signal VPOS : INTEGER RANGE 0 TO 1500;
	
	signal red : std_logic_vector(4 downto 0);
	signal green : std_logic_vector(5 downto 0);
	signal blue : std_logic_vector(4 downto 0);
	
	
	signal w_sw_1 : std_logic;
	signal w_sw_2 : std_logic;
	signal w_sw_3 : std_logic;
	signal w_sw_4 : std_logic;

--	component sync is
--	generic(horizontal_px : integer;
--			 vertical_px : integer;
--			 H_Front_Porch : integer;
--			 H_Sync_Pulse : integer;
--			 H_Back_Porch : integer;
--			 V_Front_Porch : integer;
--			 V_Sync_Pulse : integer;
--			 V_Back_Porch : integer);
--	port(i_clk : in std_logic;
--		o_HPOS : out INTEGER RANGE 0 TO 1500;
--		o_VPOS : out INTEGER RANGE 0 TO 1500;
--		hsync : out std_logic;
--		vsync : out std_logic);
--	end component sync;	

begin

--C1 : sync GENERIC MAP(horizontal_px, vertical_px, H_Front_Porch, H_Sync_Pulse, H_Back_Porch, V_Front_Porch, V_Sync_Pulse, V_Back_Porch) PORT MAP (i_clk_50,HPOS, VPOS, o_hsync,o_vsync);

C1: entity work.sync GENERIC MAP(
	horizontal_px, 
	vertical_px, 
	H_Front_Porch, 
	H_Sync_Pulse, 
	H_Back_Porch, 
	V_Front_Porch, 
	V_Sync_Pulse, 
	V_Back_Porch) 
	PORT MAP (i_clk => i_clk_50, 
	o_HPOS => HPOS, 
	o_VPOS => VPOS, 
	hsync => o_hsync, 
	vsync => o_vsync);

C2: entity work.display generic map(
	horizontal_px, 
	vertical_px) 
	port map (i_clk => i_clk_50, 
	x => HPOS, y => VPOS, 
	red => red, blue => 
	blue ,green => green);
	
	
btn1: entity work.debounce_btn port map(
	i_clk =>i_clk_50,
	i_sw => i_sw_1,
	o_sw => w_sw_1);
	
btn2: entity work.debounce_btn port map(
	i_clk =>i_clk_50,
	i_sw => i_sw_2,
	o_sw => w_sw_2);
	
btn3: entity work.debounce_btn port map(
	i_clk =>i_clk_50,
	i_sw => i_sw_3,
	o_sw => w_sw_3);
	
btn4: entity work.debounce_btn port map(
	i_clk =>i_clk_50,
	i_sw => i_sw_4,
	o_sw => w_sw_4);
	

	o_red <= red;
	o_green <= green;
	o_blue <= blue;

end Architecture RTL;