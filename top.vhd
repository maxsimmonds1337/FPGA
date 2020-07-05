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
		HS_top			:	out	STD_LOGIC;		-- Horiontal sync
		VS_top			:	out	STD_LOGIC;		-- Virticle sync
		R0_top			:	out	STD_LOGIC;		-- Red bit 1
		R1_top			:	out	STD_LOGIC;		-- Red bit 1
		R2_top			:	out	STD_LOGIC;		-- Red bit 1
		R3_top			:	out	STD_LOGIC;		-- Red bit 1

		G0_top			:	out	STD_LOGIC;		-- Red bit 1
		G1_top			:	out	STD_LOGIC;		-- Red bit 1
		G2_top			:	out	STD_LOGIC;		-- Red bit 1
		G3_top			:	out	STD_LOGIC;		-- Red bit 1

		B0_top			:	out	STD_LOGIC;		-- Red bit 1
		B1_top			:	out	STD_LOGIC;		-- Red bit 1
		B2_top			:	out	STD_LOGIC;		-- Red bit 1
		B3_top			:	out	STD_LOGIC		-- Red bit 1
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
	end component;

begin

	VGA_p: VGA_640x480
			PORT MAP (
				-- inputs
				pixel_clk => pixel_clk,

				--outputs
				hsync => HS_top,
				vsync => VS_top,
				
				R0 => R0_top,
				R1 => R1_top,
				R2 => R2_top,
				R3 => R3_top,
				
				G0 => G0_top,
				G1 => G1_top,
				G2 => G2_top,
				G3 => G3_top,
				
				B0 => B0_top,
				B1 => B1_top,
				B2 => B2_top,
				B3 => B3_top
			);
	

end BEHAVIORAL;