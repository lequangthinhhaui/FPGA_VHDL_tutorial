library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_ram is
  generic (
    DATA_WIDTH : integer := 8;    -- Number of bits in each word
    ADDR_WIDTH : integer := 4     -- Number of address bits
  );
  port (
    clk     : in  std_logic;                          -- Clock signal
    addr    : in  std_logic_vector(ADDR_WIDTH-1 downto 0); -- Address input
    data_in : in  std_logic_vector(DATA_WIDTH-1 downto 0); -- Data input
    data_out: out std_logic_vector(DATA_WIDTH-1 downto 0)  -- Data output
  );
end test_ram;

architecture rtl of test_ram is
  -- BRAM memory array
  type ram_type is array (2**ADDR_WIDTH-1 downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0);
  
  signal ram : ram_type := (others => (others => '0')); -- Initialize to zero
  signal    we      :  std_logic:= '1';                          -- Write enable
begin
  process (clk)
  
  begin
    if rising_edge(clk) then
      if we = '1' then
        ram(to_integer(unsigned(addr))) <= data_in;  -- Write operation
      end if;
      data_out <= ram(to_integer(unsigned(addr)));  -- Read operation
    end if;
  end process;
end rtl;