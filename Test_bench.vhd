library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_top is
-- Testbench không có port
end entity tb_top;

architecture sim of tb_top is

  -- Hằng số chu kỳ Clock: 50 MHz -> 20 ns
  constant CLK_PERIOD : time := 20 ns;

  -- Khai báo các tín hiệu tương ứng với Port của DUT
  signal clk_i       : std_ulogic := '0';
  signal rstn_i      : std_ulogic := '0';
  signal uart0_txd_o : std_ulogic;
  signal uart0_rxd_i : std_ulogic := '1'; -- UART Idle ở mức 1
  signal trig_o      : std_ulogic;
  signal echo_i      : std_ulogic := '0';
  signal led_r_o     : std_ulogic;
  signal led_y_o     : std_ulogic;
  signal led_g_o     : std_ulogic;

begin

  -- Instantiate Device Under Test (DUT)
  dut: entity work.top
    port map (
      clk_i       => clk_i,
      rstn_i      => rstn_i,
      uart0_txd_o => uart0_txd_o,
      uart0_rxd_i => uart0_rxd_i,
      trig_o      => trig_o,
      echo_i      => echo_i,
      led_r_o     => led_r_o,
      led_y_o     => led_y_o,
      led_g_o     => led_g_o
    );

  -- 1. Tạo xung Clock (50 MHz)
  clk_process : process
  begin
    clk_i <= '0';
    wait for CLK_PERIOD / 2;
    clk_i <= '1';
    wait for CLK_PERIOD / 2;
  end process;

  -- 2. Tạo tín hiệu Reset hệ thống
  rst_process : process
  begin
    rstn_i <= '0'; -- Kích hoạt reset (tích cực mức thấp)
    wait for 100 ns;
    rstn_i <= '1'; -- Nhả reset để CPU hoạt động
    wait;          -- Chờ vĩnh viễn
  end process;

  -- 3. Mô phỏng hành vi của cảm biến siêu âm (Ví dụ: HC-SR04)
  sensor_sim : process
  begin
    -- Khởi tạo chân echo
    echo_i <= '0';

    loop
      -- Chờ CPU phát tín hiệu Trigger (cạnh lên)
      wait until rising_edge(trig_o);
      
      -- Chờ CPU kết thúc xung Trigger (thường kéo dài khoảng 10us)
      wait until falling_edge(trig_o);

      -- Mô phỏng độ trễ xử lý nội bộ của cảm biến trước khi phát sóng âm
      wait for 400 us;

      -- Kéo chân Echo lên mức cao
      echo_i <= '1';
      
      -- *** ĐIỀU CHỈNH KHOẢNG CÁCH TẠI ĐÂY ***
      -- Giả lập vật cản ở khoảng cách 10cm. 
      -- Công thức: Thời gian = (Khoảng cách * 2) / Vận tốc âm thanh
      -- T = (10cm * 2) / 34000 cm/s = ~588 micro-giây
      wait for 588 us; 
      
      -- Hạ chân Echo xuống
      echo_i <= '0';

      -- Nghỉ một chút trước khi nhận lần Trigger tiếp theo
      wait for 10 ms;
    end loop;
  end process;

end architecture sim;