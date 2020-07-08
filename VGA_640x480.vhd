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
end VGA_640x480;

architecture BEHAVIORAL of VGA_640x480 is

	--signal declarations (horizontal)
 	signal h_counter		:	STD_LOGIC_VECTOR (9 downto 0) := "0000000000"; -- horizontal clock counter
	signal h_bp				:	STD_LOGIC_VECTOR (4 downto 0) := "10000"; -- horizontal backporch, 16 pixels
	signal h_fp				:	STD_LOGIC_VECTOR (4 downto 0) := "10000"; -- horizontal frontporch, 16 pixels
	signal h_sp				:	STD_LOGIC_VECTOR (7 downto 0) := "10000000";	-- horizontal sync pulse, 128 pixels
	signal h_p				:	STD_LOGIC_VECTOR (9 downto 0) := "1100100000"; -- horizontal pixels (16 + 16 + 630 + 128 = 800)

	--signal declarations (virticle)
 	signal v_counter		:	STD_LOGIC_VECTOR (9 downto 0) := "0000000000"; -- virtcle clock counter
	signal v_bp				:	STD_LOGIC_VECTOR (4 downto 0) := "11101"; -- virtcle backporch, 29 pixels
	signal v_fp				:	STD_LOGIC_VECTOR (4 downto 0) := "01010"; -- virtcle frontporch, 10 pixels
	signal v_sp				:	STD_LOGIC_VECTOR (7 downto 0) := "00000010";	-- virticle sync pulse, 2
	signal v_p				:	STD_LOGIC_VECTOR (9 downto 0) := "1000001001"; -- virtcle pixels (29 + 2 + 480 +  = 800)
	signal RGB				:	STD_LOGIC_VECTOR (11 downto 0) := "000000000000"; -- rgb

	type int_array is array(natural range <>) of integer;
	signal lut_addr: integer := 0;
	signal uint_lut_out: integer := 0;
	signal lut_out : std_logic_vector (3 downto 0) := "0000";

	--lut
	constant lut_data: int_array(0 to 639) := (8,8,8,8,8,8,8,8,14,14,14,14,14,14,14,14,15,15,15,15,15,15,15,15,9,9,9,9,9,9,9,9,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,5,5,5,5,5,5,5,5,13,13,13,13,13,13,13,13,15,15,15,15,15,15,15,15,11,11,11,11,11,11,11,11,3,3,3,3,3,3,3,3,0,0,0,0,0,0,0,0,3,3,3,3,3,3,3,3,11,11,11,11,11,11,11,11,15,15,15,15,15,15,15,15,13,13,13,13,13,13,13,13,5,5,5,5,5,5,5,5,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,9,9,9,9,9,9,9,9,15,15,15,15,15,15,15,15,14,14,14,14,14,14,14,14,7,7,7,7,7,7,7,7,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,6,6,6,6,6,6,6,6,14,14,14,14,14,14,14,14,15,15,15,15,15,15,15,15,10,10,10,10,10,10,10,10,2,2,2,2,2,2,2,2,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,12,12,12,12,12,12,12,12,15,15,15,15,15,15,15,15,12,12,12,12,12,12,12,12,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,10,10,10,10,10,10,10,10,15,15,15,15,15,15,15,15,13,13,13,13,13,13,13,13,6,6,6,6,6,6,6,6,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,8,8,8,8,8,8,8,8,14,14,14,14,14,14,14,14,15,15,15,15,15,15,15,15,8,8,8,8,8,8,8,8,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,5,5,5,5,5,5,5,5,13,13,13,13,13,13,13,13,15,15,15,15,15,15,15,15,11,11,11,11,11,11,11,11,3,3,3,3,3,3,3,3,0,0,0,0,0,0,0,0,3,3,3,3,3,3,3,3,11,11,11,11,11,11,11,11,15,15,15,15,15,15,15,15,13,13,13,13,13,13,13,13,5,5,5,5,5,5,5,5,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,9,9,9,9,9,9,9,9,15,15,15,15,15,15,15,15,14,14,14,14,14,14,14,14,7,7,7,7,7,7,7,7,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,14,14,14,14,14,14,14,14,15,15,15,15,15,15,15,15,10,10,10,10,10,10,10,10,2,2,2,2,2,2,2,2,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,12,12,12,12,12,12,12,12,15,15,15,15,15,15,15,15,12,12,12,12,12,12,12,12,4,4,4,4,4,4,4,4);
	
	begin
	
	VGA: process(pixel_clk) is
		begin
				
			if(rising_edge(pixel_clk) ) then

				R0  <= RGB(0);			
				R1	<= RGB(1);		
				R2	<= RGB(2);	
				R3	<= RGB(3);
		
				G0  <= RGB(4);			
				G1	<= RGB(5);		
				G2	<= RGB(6);	
				G3	<= RGB(7);
		
				B0  <= RGB(8);			
				B1	<= RGB(9);		
				B2	<= RGB(10);	
				B3	<= RGB(11);
				
				h_counter <= h_counter + 1; -- inc counter

				-- virtcle stuff
				if(v_counter < v_sp) then
					
					vsync <= '0';
					hsync <= '1';

				elsif(v_counter > v_sp AND v_counter < v_sp + v_bp) then -- in V back porch 

					vsync <= '1';	-- set v sync high

					-- Send black during back porch
 					RGB <= (others => '0'); -- reset
				
				elsif(v_counter < v_sp) then
					
					vsync <= '0';
					hsync <= '1';

				elsif(v_counter > v_sp AND v_counter < v_sp + v_bp) then -- in V back porch 

					vsync <= '1';	-- set v sync high

					-- Send black during back porch
					RGB <= (others => '0'); -- reset
			
				elsif(v_counter < v_p AND v_counter > v_p - v_fp) then	-- in V front porch
				
					-- Send black during front porch
					RGB <= (others => '0'); -- reset


				elsif(v_counter = v_p) then		-- reached end of raster, restart
					
					v_counter <= "0000000000";
				
				end if;

				-- horizontal stuff
				if(h_counter < h_sp) then  -- now V sync and back porch is done, start horizontal. 
												-- sync pulse
					hsync <= '0';

				elsif(h_counter < h_sp + h_bp AND h_counter > h_sp) then		-- if counter is less than the sync pulse + back porch, AND greater than the sync pulse, we're in the back port section
					
					hsync <= '1';	-- set vsync high

					-- Send black during back porch
					RGB <= (others => '0'); -- reset

				elsif(h_counter > h_sp + h_bp AND h_counter < h_p - h_fp) then		-- if counter is greater than the sync pulse + back porch, AND less than the number of pixels - the front porch, we're in
																					-- the data section
					-- calc the plasma
					uint_lut_out <= lut_data(to_integer(unsigned(h_counter - h_sp - h_bp)));
					lut_out <= std_logic_vector(to_unsigned(uint_lut_out, lut_out'length));

					RGB <= lut_out & lut_out & lut_out;   --std_logic_vector(shift_left(unsigned(lut_out_tb), 1));;
				
				elsif(h_counter < h_p AND h_counter > h_p - h_fp) then		-- if the counter is less than the number of pixels AND greater than the number of pixels - the frront porch, we're in the front porch
	
					-- send black again
					RGB <= (others => '0'); -- reset

				elsif(h_counter = h_p) then
				
					h_counter <= "0000000000"; -- reset the counter
					v_counter <= v_counter + 1;	-- inc counter
				end if;

			end if;
		

		end process;
	
end BEHAVIORAL;
