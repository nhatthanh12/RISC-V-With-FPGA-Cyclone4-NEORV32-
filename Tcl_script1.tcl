set_location_assignment PIN_24 -to clk_i
set_location_assignment PIN_88 -to rstn_i
set_location_assignment PIN_10 -to uart0_txd_o
set_location_assignment PIN_23 -to uart0_rxd_i
set_location_assignment PIN_112 -to trig_o
set_location_assignment PIN_113 -to echo_i
set_location_assignment PIN_121 -to led_r_o
set_location_assignment PIN_120 -to led_y_o
set_location_assignment PIN_125 -to led_g_o

# Thiết lập mức logic 3.3V
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to clk_i
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to rstn_i
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to uart0_txd_o
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to uart0_rxd_i
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to trig_o
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to echo_i
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to led_r_o
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to led_y_o
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to led_g_o