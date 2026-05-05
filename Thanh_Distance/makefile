# =============================================================================
# NEORV32 Makefile - Ubuntu/WSL Edition (Hard Linker Fix)
# =============================================================================

# 1. TÊN BỘ BIÊN DỊCH
RISCV_PREFIX ?= riscv64-unknown-elf-

# 2. CẤU HÌNH CHIP NEORV32
MARCH = rv32i_zicsr_zifencei
MABI  = ilp32

# 3. THƯ MỤC GỐC NEORV32
NEORV32_HOME ?= ../../..

# 4. FLAGS CẤU HÌNH
# Bỏ hoàn toàn việc dùng thư viện chuẩn của hệ thống
USER_FLAGS += -Os -ffreestanding -nostartfiles -mstrict-align -nostdlib
USER_FLAGS += -I/usr/include/newlib

# 5. CẤU HÌNH BỘ NHỚ
USER_FLAGS += -Wl,--defsym,__neorv32_rom_size=16k
USER_FLAGS += -Wl,--defsym,__neorv32_ram_size=8k

# 6. GHI ĐÈ LD_LIBS ĐỂ KHÔNG TÌM -lm VÀ -lc (QUAN TRỌNG NHẤT)
# Ta đặt tên biến này để nó ghi đè lên giá trị mặc định trong common.mk
LD_LIBS = -lgcc

# BAO GỒM FILE COMMON CỦA HÃNG
include $(NEORV32_HOME)/sw/common/common.mk