 --library declaration
library IEEE;

use IEEE.std_logic_1164.all;            -- basic IEEE library
use IEEE.numeric_std.all;               -- IEEE library for the unsigned type and various arithmetic operators


-- Top level entity - defines the IO
entity TOP is
	port(
		--inputs
		pixel_clk		:	in	STD_LOGIC;		-- Clock in  (25.175 MHz) on P26
		--reset			:	in	STD_LOGIC;		-- SW5 (J17)

		--outputs
		HS_top			:	out	STD_LOGIC		-- Horiontal sync
		--VS_top			:	out	STD_LOGIC;		-- Virticle sync
		--R_out_top		:	out	STD_LOGIC;		-- Red signal out
		--G_out_top		:	out	STD_LOGIC;		-- Green signal out
		--B_out_top		:	out	STD_LOGIC		-- Blue signal out
	);
end TOP;

--functionality	
architecture BEHAVIORAL of TOP is	

	--signal r_HS_top 		: 	STD_LOGIC := '0';
	--signal r_VS_top 		: 	STD_LOGIC := '0';
	--signal r_R_out_top 	:	STD_LOGIC := '0';
	--signal r_G_out_top 	:	STD_LOGIC := '0';
	--signal r_B_out_top 	:	STD_LOGIC := '0';

	component VGA_640x480 is
		port(
			--inputs
			pixel_clk	:	in	STD_LOGIC;		-- pixel clock, this is at 25.175MH

			--outputs
			hsync		:	out	STD_LOGIC		-- horizontal sync
		);
	end component;

begin

	VGA_p: VGA_640x480
			PORT MAP (
				-- inputs
				pixel_clk => pixel_clk,

				--outputs
				hsync => HS_top
			);
	

end BEHAVIORAL;