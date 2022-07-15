LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALU IS
PORT( Op_code : IN STD_LOGIC_VECTOR( 2 DOWNTO 0 );
A, B : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );
Y : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 ) );
END ALU;

architecture ALU_arch of ALU is

begin
	proc_ALU: process (Op_code)
	begin
		case (Op_code) is
			when "000" => Y <= A;
			when "001" => Y <= std_logic_vector(unsigned(A)+unsigned(B));
			when "010" => Y <= std_logic_vector(unsigned(A)-unsigned(B));
			when "011" => Y <= A and B;
			when "100" => Y <= A or B;
			when "101" => Y <= std_logic_vector((unsigned(A)+1));
			when "110" => Y <= std_logic_vector((unsigned(A)-1));
			when "111" => Y <= B;
			when others => Y <= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		end case;
	end process proc_ALU;
end ALU_arch;

