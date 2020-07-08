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
	signal reset_tb		: 	STD_LOGIC	:=	'0'; 						-- clock signal, default 0

	signal HS_top_tb		: 	STD_LOGIC	:=	'0'; 						-- clock signal, default 0
	signal VS_top_tb		: 	STD_LOGIC	:=	'0'; 						-- clock signal, default 0
	signal R_out_top_tb		: 	STD_LOGIC	:=	'0'; 						-- clock signal, default 0
	signal G_out_top_tb		: 	STD_LOGIC	:=	'0'; 						-- clock signal, default 0
	signal B_out_top_tb		: 	STD_LOGIC	:=	'0'; 						-- clock signal, default 0

	component top is
		port(
			--inputs
			pixel_clk	:	in	STD_LOGIC;		-- pixel clock, this is at 25.175MH

			--outputs
			hsync		:	out	STD_LOGIC;		-- horizontal sync
			vsync		:	out	STD_LOGIC;		-- virtcle sync
			R0			:	out	STD_LOGIC;		-- Red bit 1
			R1			:	out	STD_LOGIC;		-- Red bit 1
			R2			:	out	STD_LOGIC;		-- Red bit 1
			R3			:	out	STD_LOGIC;		-- Red bit 1

			G0			:	out	STD_LOGIC;		-- Red bit 1
			G1			:	out	STD_LOGIC;		-- Red bit 1
			G2			:	out	STD_LOGIC;		-- Red bit 1
			G3			:	out	STD_LOGIC;		-- Red bit 1

			B0			:	out	STD_LOGIC;		-- Red bit 1
			B1			:	out	STD_LOGIC;		-- Red bit 1
			B2			:	out	STD_LOGIC;		-- Red bit 1
			B3			:	out	STD_LOGIC		-- Red bit 1
		);
	end component top;
 
	begin
		CLK: 	clk_tb 	<= not clk_tb after C_PERIOD/2;					-- single line process to generate the clock

		TOP_p: top
			PORT MAP (
			--inputs
			pixel_clk	

			--outputs
			hsync	
			vsync		
			R0			
			R1			
			R2			
			R3			

			G0			
			G1			
			G2			
			G3			

			B0			
			B1		
			B2			
			B3		
			);

end BEHAVIORAL;
