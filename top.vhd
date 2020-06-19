 --library declaration
library IEEE;

use IEEE.std_logic_1164.all;            -- basic IEEE library
use IEEE.numeric_std.all;               -- IEEE library for the unsigned type and various arithmetic operators


-- Top level entity - defines the IO
entity TOP is
	port(
		--inputs
		clk_in_top		:	in	STD_LOGIC	:=	'0';		-- Clock in  (25.175 MHz) on P26

		--outputs
		HS_top			:	out	STD_LOGIC	:=	'0';		-- Horiontal sync
		VS_top			:	out	STD_LOGIC;		-- Virticle sync
		R_out_top		:	out	STD_LOGIC;		-- Red signal out
		G_out_top		:	out	STD_LOGIC;		-- Green signal out
		B_out_top		:	out	STD_LOGIC		-- Blue signal out
	);
end TOP;

--functionality
architecture BEHAVIORAL of TOP is
	begin

	clk_out: process(clk_in_top) is
		begin
			if(rising_edge(clk_in_top)) then
		
				--combitorial logic
				HS_top <= clk_in_top;	-- out the clock
			end if;
		end process clk_out;
end BEHAVIORAL;