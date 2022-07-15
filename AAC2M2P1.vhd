LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
    TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;

architecture bit_counter of AAC2M2P1 is 
begin
	TC <= Q(0) and Q(1) and Q(2) and Q(3) and CET;
	count_proc: process (CP, PE, CEP, CET)
	begin
	
	if (rising_edge(CP)) then 
	  if SR ='0' then
	    Q <= "0000";
	  elsif (PE = '0') then
	    Q <= P;
	  elsif (Q="1111") then Q <= "0000";
	  elsif (CEP='1') and (CET='1') then
	    Q <= std_logic_vector(unsigned(Q)+1);
	  end if;
	end if;
	end process count_proc;
end architecture bit_counter;