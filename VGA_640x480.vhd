 --library declaration
library IEEE;

use IEEE.std_logic_1164.all;            -- basic IEEE library
use IEEE.std_logic_unsigned.all;		-- required for std logic vecotrs
use IEEE.numeric_std.all;               -- IEEE library for the unsigned type and various arithmetic operators


-- Top level entity - defines the IO
entity VGA_640x480 is
	port(
	--inputs
	pixel_clk	:	in	STD_LOGIC;		-- pixel clock, this is at 25.175MH

	--outputs
	hsync		:	out	STD_LOGIC;		-- horizontal sync
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
end VGA_640x480;

architecture BEHAVIORAL of VGA_640x480 is
	
	--signal declarations
 	signal h_counter		:	STD_LOGIC_VECTOR (11 downto 0) := "000000000000"; -- horizontal clock counter
	signal h_bp				:	STD_LOGIC_VECTOR (4 downto 0) := "10000"; -- horizontal backporch, 16 pixels
	signal h_fp				:	STD_LOGIC_VECTOR (4 downto 0) := "10000"; -- horizontal frontporch, 16 pixels
	signal h_sp				:	STD_LOGIC_VECTOR (7 downto 0) := "10000000";	-- horizontal sync pulse
	signal h_p				:	STD_LOGIC_VECTOR (9 downto 0) := "1100100000"; -- horizontal pixels (16 + 16 + 630 + 128 = 800)
	
	begin
	
	VGA: process(pixel_clk) is
		begin
			if(h_counter = 0) then
				hsync <= '1';
			elsif(h_counter < h_sp) then
				hsync <= '0'; -- set the hsync
			elsif(h_counter = h_sp) then
				hsync <= '1';	-- not needed now
			end if;
			h_counter <= h_counter + 1;
		end process;
	
end BEHAVIORAL;
