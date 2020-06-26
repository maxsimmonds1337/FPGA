-- FPGA projects using VHDL/ VHDL 
-- fpga4student.com
-- VHDL code for D Flip FLop
-- VHDL code for Rising edge D flip flop with Asynchronous Reset high
Library IEEE;
USE IEEE.Std_logic_1164.all;

entity RisingEdge_DFlipFlop_AsyncResetHigh is 
   port(
      Q : out std_logic;    
      Clk :in std_logic;  
   sync_reset: in std_logic;  
      D :in  std_logic    
   );
end RisingEdge_DFlipFlop_AsyncResetHigh;
architecture Behavioral of RisingEdge_DFlipFlop_AsyncResetHigh is  
begin  

	Q <= Clk;
-- process(Clk,sync_reset)
-- begin 
--     if(sync_reset='1') then 
--   Q <= '0';
--     elsif(rising_edge(Clk)) then
--   Q <= '1'; 
--		else
--	Q <= '0';
--  end if;      
-- end process;  
end Behavioral; 



-- --library declaration
--library IEEE;
--
--use IEEE.std_logic_1164.all;            -- basic IEEE library
--use IEEE.numeric_std.all;               -- IEEE library for the unsigned type and various arithmetic operators
--
--
---- Top level entity - defines the IO
--entity TOP is
--	port(
--		--inputs
--		clk_in_top		:	in	STD_LOGIC;		-- Clock in  (25.175 MHz) on P26
--		reset				:	in	STD_LOGIC;
--
--		--outputs
--		HS_top			:	out	STD_LOGIC		-- Horiontal sync
--		--VS_top			:	out	STD_LOGIC;		-- Virticle sync
--		--R_out_top		:	out	STD_LOGIC;		-- Red signal out
--		--G_out_top		:	out	STD_LOGIC;		-- Green signal out
--		--B_out_top		:	out	STD_LOGIC		-- Blue signal out
--	);
--end TOP;
--
----functionality	
--architecture BEHAVIORAL of TOP is	
--	
--	--signal r_HS_top 		: 	STD_LOGIC := '0';
--	--signal r_VS_top 		: 	STD_LOGIC := '0';
--	--signal r_R_out_top 	:	STD_LOGIC := '0';
--	--signal r_G_out_top 	:	STD_LOGIC := '0';
--	--signal r_B_out_top 	:	STD_LOGIC := '0';
--
--	begin
--	
--	process(clk_in_top, reset) is
--	begin
--		if reset = '1' then
--			HS_top <= '0';
--		elsif (rising_edge(clk_in_top) ) then 
--			HS_top <= '1';
--		end if;
--	end process;
--	
--	--HS_top <= r_HS_top;
--	
--end BEHAVIORAL;