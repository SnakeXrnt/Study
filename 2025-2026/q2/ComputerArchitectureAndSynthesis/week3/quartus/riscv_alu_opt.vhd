library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity riscv_alu_opt is 
    port (
        A       : in STD_LOGIC_VECTOR(31 downto 0);
        B       : in STD_LOGIC_VECTOR(31 downto 0);
        ALUOP   : in STD_LOGIC_VECTOR(2 downto 0);
        Result  : out STD_LOGIC_VECTOR(31 downto 0);
        Zero    : out STD_LOGIC
    );
end entity riscv_alu_opt;

architecture behaviour of riscv_alu_opt is 

    signal ALUR_temp  : STD_LOGIC_VECTOR(31 downto 0);
    constant OP_AND   : STD_LOGIC_VECTOR(2 downto 0) := "000";
    constant OP_OR    : STD_LOGIC_VECTOR(2 downto 0) := "001";
    constant OP_ADD   : STD_LOGIC_VECTOR(2 downto 0) := "010";
    constant OP_SUB   : STD_LOGIC_VECTOR(2 downto 0) := "011";
    constant OP_SSL   : STD_LOGIC_VECTOR(2 downto 0) := "100";
	 constant OP_SRL   : STD_LOGIC_VECTOR(2 downto 0) := "101";
    constant OP_SRA   : STD_LOGIC_VECTOR(2 downto 0) := "110";
    constant OP_SLT   : STD_LOGIC_VECTOR(2 downto 0) := "111";
    signal SHAMT      : INTEGER range 0 to 31;
    signal SLT_Result : STD_LOGIC_VECTOR(31 downto 0);


begin
    SHAMT <= TO_INTEGER(UNSIGNED(B(4 downto 0)));
    SLT_Result <= (others => '0') when (SIGNED(A) >= SIGNED(B)) else x"00000001"; 
    with ALUOP select ALUR_temp <=
        A and B when OP_AND,
        A or B when OP_OR,
        STD_LOGIC_VECTOR(UNSIGNED(A) + UNSIGNED(B)) when OP_ADD,
        STD_LOGIC_VECTOR(UNSIGNED(A) - UNSIGNED(B)) when OP_SUB,
        STD_LOGIC_VECTOR(SHIFT_LEFT(UNSIGNED(A), SHAMT)) when OP_SSL,
        STD_LOGIC_VECTOR(SHIFT_RIGHT(UNSIGNED(A), SHAMT)) when OP_SRL,
        STD_LOGIC_VECTOR(SHIFT_RIGHT(SIGNED(A), SHAMT)) when OP_SRA,
        SLT_Result when OP_SLT,
        (others => 'X') when others;

    Result <= ALUR_temp;

    Zero <= '1' when ALUR_temp = x"00000000" else '0';

end architecture behaviour;


    
