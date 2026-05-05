# RISC-V-With-FPGA-Cyclone4-NEORV32-


📡 Distance Measurement & Warning System using FPGA + NEORV32
📌 Giới thiệu
Dự án này triển khai hệ thống đo khoảng cách bằng cảm biến siêu âm trên FPGA, sử dụng nhân NEORV32 RISC-V. Kết quả đo được hiển thị qua UART và đồng thời điều khiển LED cảnh báo theo ba mức: Nguy hiểm (Đỏ), Cảnh báo (Vàng), An toàn (Xanh).

⚙️ Thành phần chính
Phần cứng:

FPGA board (hỗ trợ Quartus)

Nhân xử lý NEORV32 RISC-V tích hợp

Cảm biến siêu âm (HC-SR04 hoặc tương tự)

LED chỉ thị (Đỏ, Vàng, Xanh)

Phần mềm:

Quartus project (thiết kế phần cứng NEORV32)

main.c (chương trình đo khoảng cách và cảnh báo)

NEORV32 SDK / toolchain

📂 Cấu trúc thư mục
Mã
/quartus     -> File dự án Quartus (thiết kế FPGA + NEORV32)
/software    -> main.c và các file liên quan
/docs        -> Tài liệu, sơ đồ kết nối
🛠️ Build & Nạp chương trình
Clone NEORV32

bash
git clone https://github.com/stnolting/neorv32.git
Mở dự án Quartus

Import file .qpf và .qsf trong thư mục /quartus.

Compile để tạo bitstream cho FPGA.

Nạp bitstream vào FPGA board.

Build chương trình C

Sử dụng NEORV32 toolchain để compile main.c.

Nạp chương trình vào FPGA qua UART/bootloader.

🚀 Chạy chương trình
Kết nối cảm biến siêu âm với GPIO của FPGA:

Trigger → GPIO0

Echo → GPIO1

Kết nối LED với GPIO2 (Đỏ), GPIO3 (Vàng), GPIO4 (Xanh).

Mở UART terminal (baudrate 19200).

Chạy chương trình, kết quả sẽ hiển thị:

Khoảng cách đo được (cm)

Trạng thái cảnh báo (Đỏ/Vàng/Xanh)

📖 Logic chương trình
Gửi xung Trigger từ GPIO0.

Đo thời gian Echo từ GPIO1.

Tính toán khoảng cách: distance = count / 110.

Hiển thị kết quả qua UART.

Điều khiển LED theo ngưỡng:

< 10 cm → Nguy hiểm (Đỏ)

10–30 cm → Cảnh báo (Vàng)

> 30 cm → An toàn (Xanh)

✅ Kết quả mong đợi
Hệ thống đo khoảng cách chính xác trong phạm vi 2–400 cm.

UART hiển thị dữ liệu đo và trạng thái cảnh báo.

LED báo hiệu trực quan theo khoảng cách.
