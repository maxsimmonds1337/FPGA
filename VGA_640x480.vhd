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
	signal lut_addr: integer;
	signal lut_out: integer;

	--lut
	constant lut_data: int_array(0 to 639):= (128, 128, 128, 128, 128, 128, 128, 128, 235, 235, 235, 235, 235, 235, 235, 235, 244, 244, 244, 244, 244, 244, 244, 244, 146, 146, 146, 146, 
								146, 146, 146, 146, 31, 31, 31, 31, 31, 31, 31, 31, 5, 5, 5, 5, 5, 5, 5, 5, 92, 92, 92, 92, 92, 92, 92, 92, 212, 212, 212, 212, 212, 212, 212, 212, 254, 
								254, 254, 254, 254, 254, 254, 254, 180, 180, 180, 180, 180, 180, 180, 180, 58, 58, 58, 58, 58, 58, 58, 58, 0, 0, 0, 0, 0, 0, 0, 0, 59, 59, 59, 59, 59, 59,
								59, 59, 181, 181, 181, 181, 181, 181, 181, 181, 254, 254, 254, 254, 254, 254, 254, 254, 211, 211, 211, 211, 211, 211, 211, 211, 91, 91, 91, 91, 91, 91, 91,
								91, 4, 4, 4, 4, 4, 4, 4, 4, 31, 31, 31, 31, 31, 31, 31, 31, 147, 147, 147, 147, 147, 147, 147, 147, 244, 244, 244, 244, 244, 244, 244, 244, 235, 235, 235,
								235, 235, 235, 235, 235, 126, 126, 126, 126, 126, 126, 126, 126, 19, 19, 19, 19, 19, 19, 19, 19, 12, 12, 12, 12, 12, 12, 12, 12, 111, 111, 111, 111, 111, 
								111, 111, 111, 225, 225, 225, 225, 225, 225, 225, 225, 250, 250, 250, 250, 250, 250, 250, 250, 162, 162, 162, 162, 162, 162, 162, 162, 43, 43, 43, 43, 43,
								43, 43, 43, 1, 1, 1, 1, 1, 1, 1, 1, 76, 76, 76, 76, 76, 76, 76, 76, 198, 198, 198, 198, 198, 198, 198, 198, 255, 255, 255, 255, 255, 255, 255, 255, 195, 195,
								195, 195, 195, 195, 195, 195, 73, 73, 73, 73, 73, 73, 73, 73, 1, 1, 1, 1, 1, 1, 1, 1, 45, 45, 45, 45, 45, 45, 45, 45, 165, 165, 165, 165, 165, 165, 165, 165, 
								251, 251, 251, 251, 251, 251, 251, 251, 223, 223, 223, 223, 223, 223, 223, 223, 107, 107, 107, 107, 107, 107, 107, 107, 10, 10, 10, 10, 10, 10, 10, 10, 21, 21, 
								21, 21, 21, 21, 21, 21, 130, 130, 130, 130, 130, 130, 130, 130, 236, 236, 236, 236, 236, 236, 236, 236, 243, 243, 243, 243, 243, 243, 243, 243, 143, 143, 143, 
								143, 143, 143, 143, 143, 29, 29, 29, 29, 29, 29, 29, 29, 5, 5, 5, 5, 5, 5, 5, 5, 94, 94, 94, 94, 94, 94, 94, 94, 213, 213, 213, 213, 213, 213, 213, 213, 254, 
								254, 254, 254, 254, 254, 254, 254, 178, 178, 178, 178, 178, 178, 178, 178, 56, 56, 56, 56, 56, 56, 56, 56, 0, 0, 0, 0, 0, 0, 0, 0, 61, 61, 61, 61, 61, 61, 61,
							    61, 183, 183, 183, 183, 183, 183, 183, 183, 255, 255, 255, 255, 255, 255, 255, 255, 209, 209, 209, 209, 209, 209, 209, 209, 88, 88, 88, 88, 88, 88, 88, 88, 4,
								4, 4, 4, 4, 4, 4, 4, 33, 33, 33, 33, 33, 33, 33, 33, 149, 149, 149, 149, 149, 149, 149, 149, 245, 245, 245, 245, 245, 245, 245, 245, 233, 233, 233, 233, 233,
								233, 233, 233, 124, 124, 124, 124, 124, 124, 124, 124, 18, 18, 18, 18, 18, 18, 18, 18, 13, 13, 13, 13, 13, 13, 13, 13, 113, 113, 113, 113, 113, 113, 113, 113,
								227, 227, 227, 227, 227, 227, 227, 227, 249, 249, 249, 249, 249, 249, 249, 249, 160, 160, 160, 160, 160, 160, 160, 160, 41, 41, 41, 41, 41, 41, 41, 41, 1, 1, 
								1, 1, 1, 1, 1, 1, 78, 78, 78, 78, 78, 78, 78, 78, 200, 200, 200, 200, 200, 200, 200, 200, 255, 255, 255, 255, 255, 255, 255, 255, 193, 193, 193, 193, 193, 193,
								193, 193, 71, 71, 71, 71, 71, 71, 71, 71);
	
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
					lut_out<= lut_data(to_integer(unsigned(h_counter - h_sp - h_bp)));
					RGB <= std_logic_vector(to_unsigned(lut_out, 12));
				
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
