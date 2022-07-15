library ieee;
use ieee.std_logic_1164.all;

entity FSM is
generic(
   A: std_logic_vector(1 downto 0) := "00";
   B: std_logic_vector(1 downto 0) := "01";
   C: std_logic_vector(1 downto 0) := "10" );
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

architecture FSM_arch of FSM is
signal CurrentState, NextState : std_logic_vector(1 downto 0);
begin
	comb_proc : process(In1, CurrentState)
		begin
		case (CurrentState) is
		when A =>
			if (In1 = '1') then NextState <= B;
			else NextState <= A;
			end if;
		when B =>
			if (In1 = '0') then NextState <= C;
			else NextState <= B;
			end if;
		when C =>
			if (In1 = '1') then NextState <= A;
			else NextState <= C;
			end if;
		when others =>
			NextState <= A;
		end case;
	end process comb_proc;
	clk_proc : process(clk, RST)
		begin
		if (RST = '1') then CurrentState <= A;
		elsif (rising_edge(clk)) then CurrentState <= NextState;
		end if;
	end process clk_proc;
	out_proc : process(CurrentState)
		begin
		if (CurrentState = A) or (CurrentState = B) then Out1 <= '0';
		elsif (CurrentState = C) then Out1 <= '1';
		end if;
	end process out_proc;
end FSM_arch;
