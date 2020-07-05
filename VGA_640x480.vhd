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
	
	begin
	
	VGA: process(pixel_clk) is
		begin
			if(rising_edge(pixel_clk) ) then
				
				h_counter <= h_counter + 1; -- inc counter


				-- virtcle stuff
				if(v_counter < v_sp) then
					
					vsync <= '0';
					hsync <= '1';

				elsif(v_counter > v_sp AND v_counter < v_sp + v_bp) then -- in V back porch 

					vsync <= '1';	-- set v sync high

					-- Send black during back porch
					R0	<= '0';
					R1	<= '0';
					R2	<= '0';
					R3	<= '0';
	
					G0	<= '0';
					G1	<= '0';
					G2	<= '0';
					G3	<= '0';
	
					B0	<= '0';
					B1	<= '0';
					B2	<= '0';
					B3	<= '0';
				
				elsif(v_counter < v_sp) then
					
					vsync <= '0';
					hsync <= '1';

				elsif(v_counter > v_sp AND v_counter < v_sp + v_bp) then -- in V back porch 

					vsync <= '1';	-- set v sync high

					-- Send black during back porch
					R0	<= '0';
					R1	<= '0';
					R2	<= '0';
					R3	<= '0';
	
					G0	<= '0';
					G1	<= '0';
					G2	<= '0';
					G3	<= '0';
	
					B0	<= '0';
					B1	<= '0';
					B2	<= '0';
					B3	<= '0';
			

				elsif(v_counter < v_p AND v_counter > v_p - v_fp) then	-- in V front porch
				
					-- Send black during front porch
					R0	<= '0';
					R1	<= '0';
					R2	<= '0';
					R3	<= '0';
	
					G0	<= '0';
					G1	<= '0';
					G2	<= '0';
					G3	<= '0';
	
					B0	<= '0';
					B1	<= '0';
					B2	<= '0';
					B3	<= '0';


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
					R0	<= '0';
					R1	<= '0';
					R2	<= '0';
					R3	<= '0';
	
					G0	<= '0';
					G1	<= '0';
					G2	<= '0';
					G3	<= '0';
	
					B0	<= '0';
					B1	<= '0';
					B2	<= '0';
					B3	<= '0';

				elsif(h_counter > h_sp + h_bp AND h_counter < h_p - h_fp) then		-- if counter is greater than the sync pulse + back porch, AND less than the number of pixels - the front porch, we're in
																					-- the data section
					
					-- turn on red
					R0	<= '1';
					R1	<= '1';
					R2	<= '1';
					R3	<= '1';
	
					G0	<= '0';
					G1	<= '0';
					G2	<= '0';
					G3	<= '0';
	
					B0	<= '0';
					B1	<= '0';
					B2	<= '0';
					B3	<= '0';
				
				elsif(h_counter < h_p AND h_counter > h_p - h_fp) then		-- if the counter is less than the number of pixels AND greater than the number of pixels - the frront porch, we're in the front porch
	
					-- send black again
					R0	<= '0';
					R1	<= '0';
					R2	<= '0';
					R3	<= '0';
	
					G0	<= '0';
					G1	<= '0';
					G2	<= '0';
					G3	<= '0';
	
					B0	<= '0';
					B1	<= '0';
					B2	<= '0';
					B3	<= '0';

				elsif(h_counter = h_p) then
				
					h_counter <= "0000000000"; -- reset the counter
					v_counter <= v_counter + 1;	-- inc counter
				end if;

			end if;

				--if(h_counter = 0) then	-- At the start, so set h sync low
	
					--hsync <= '1';
	
--				if(h_counter = 0) then	-- Keep it low for the sync pulse time
--	
--					hsync <= '0'; -- set the hsync
--	
--				elsif(h_counter = h_sp) then	-- h sync goes high when set point is done
--	
--					hsync <= '1';	
--	
--				elsif(h_counter < h_sp + h_bp AND h_counter > h_sp) then		-- if counter is less than the sync pulse + back porch, AND greater than the sync pulse, we're in the back port section
--					
--					-- Send black during back porch
--					R0	<= '0';
--					R1	<= '0';
--					R2	<= '0';
--					R3	<= '0';
--	
--					G0	<= '0';
--					G1	<= '0';
--					G2	<= '0';
--					G3	<= '0';
--	
--					B0	<= '0';
--					B1	<= '0';
--					B2	<= '0';
--					B3	<= '0';
--	
--				elsif(h_counter > h_sp + h_bp AND h_counter < h_p - h_fp) then		-- if counter is greater than the sync pulse + back porch, AND less than the number of pixels - the front porch, we're in
--																					-- the data section
--					
--					-- turn on red
--					R0	<= '1';
--					R1	<= '1';
--					R2	<= '1';
--					R3	<= '1';
--	
--					G0	<= '0';
--					G1	<= '0';
--					G2	<= '0';
--					G3	<= '0';
--	
--					B0	<= '0';
--					B1	<= '0';
--					B2	<= '0';
--					B3	<= '0';
--				
--				elsif(h_counter < h_p AND h_counter > h_p - h_fp) then		-- if the counter is less than the number of pixels AND greater than the number of pixels - the frront porch, we're in the front porch
--	
--					-- send black again
--					R0	<= '0';
--					R1	<= '0';
--					R2	<= '0';
--					R3	<= '0';
--	
--					G0	<= '0';
--					G1	<= '0';
--					G2	<= '0';
--					G3	<= '0';
--	
--					B0	<= '0';
--					B1	<= '0';
--					B2	<= '0';
--					B3	<= '0';
--
--				else
--
--					h_counter <= "0000000000";
--
--				end if;
--
--				-- increment counter each clock cycle
--				h_counter <= h_counter + 1;
--			
--			end if;

		end process;
	
end BEHAVIORAL;
