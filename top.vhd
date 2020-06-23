 --library declaration
library IEEE;

use IEEE.std_logic_1164.all;            -- basic IEEE library
use IEEE.numeric_std.all;               -- IEEE library for the unsigned type and various arithmetic operators


-- Top level entity - defines the IO
entity TOP is
	port(
		--inputs
		clk_in_top		:	in	STD_LOGIC;		-- Clock in  (25.175 MHz) on P26

		--outputs
		HS_top			:	out	STD_LOGIC;		-- Horiontal sync
		VS_top			:	out	STD_LOGIC;		-- Virticle sync
		R_out_top		:	out	STD_LOGIC;		-- Red signal out
		G_out_top		:	out	STD_LOGIC;		-- Green signal out
		B_out_top		:	out	STD_LOGIC		-- Blue signal out
	);
end TOP;

--functionality	
architecture BEHAVIORAL of TOP is	
	
	signal r_HS_top : STD_LOGIC := '0';
	signal r_VS_top : STD_LOGIC := '0';
	signal r_R_out_top : STD_LOGIC := '0';
	signal r_G_out_top : STD_LOGIC := '0';
	signal r_B_out_top : STD_LOGIC := '0';
	
	begin
	
	CLK: process(clk_in_top) is
	begin
		r_HS_top <= not r_HS_top;
	end process CLK;
	
	HS_top <= r_HS_top;
	VS_top <= r_VS_top;
	R_out_top <= r_R_out_top;
	G_out_top <= r_G_out_top;
	B_out_top <= r_B_out_top;
	
end BEHAVIORAL;