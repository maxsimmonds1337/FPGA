 --library declaration
library IEEE;

use IEEE.std_logic_1164.all;            -- basic IEEE library
use IEEE.numeric_std.all;               -- IEEE library for the unsigned type and various arithmetic operators


-- Top level entity - defines the IO
entity TOP_tb is
	--test bench has no IO
end TOP_tb;

architecture BEHAVIORAL of top_tb is

	constant C_PERIOD	:	Time		:=	39.72194638 ns;				-- 25.175MHz
	signal clk_tb		: 	STD_LOGIC	:=	'0'; 						-- clock signal, default 0

	signal HS_top_tb		: 	STD_LOGIC	:=	'0'; 						-- clock signal, default 0
	signal VS_top_tb		: 	STD_LOGIC	:=	'0'; 						-- clock signal, default 0
	signal R_out_top_tb		: 	STD_LOGIC	:=	'0'; 						-- clock signal, default 0
	signal G_out_top_tb		: 	STD_LOGIC	:=	'0'; 						-- clock signal, default 0
	signal B_out_top_tb		: 	STD_LOGIC	:=	'0'; 						-- clock signal, default 0

	component top is
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
	end component top;
 
	begin
		CLK: 	clk_tb 	<= not clk_tb after C_PERIOD/2;					-- single line process to generate the clock

		TOP_p: top
			PORT MAP (
				clk_in_top => clk_tb,

				HS_top => HS_top_tb,
				VS_top => VS_top_tb,
				R_out_top => R_out_top_tb,
				G_out_top => G_out_top_tb,
				B_out_top => B_out_top_tb
			);

end BEHAVIORAL;
