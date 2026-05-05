#include <neorv32.h>

void uart_print(char *s) {
    while (*s) { neorv32_uart0_putc(*s++); }
}

void uart_print_int_aligned(uint32_t n) {
    char buf[11];
    int i = 0;
    
    if (n == 0) { 
        buf[i++] = '0'; 
    } else {
        while (n > 0) {
            buf[i++] = (n % 10) + '0';
            n /= 10;
        }
    }
    
    // Căn lề phải cho số có tối đa 3 chữ số (0-999 cm)
    int padding = 3 - i;
    while (padding-- > 0) { neorv32_uart0_putc(' '); }
    while (i > 0) { neorv32_uart0_putc(buf[--i]); }
}

int main() {
    neorv32_uart0_setup(19200, 0);
    neorv32_gpio_port_set(0);

    // Thêm \r vào các dòng tiêu đề
    uart_print("\r\n==============================================\r\n");
    uart_print("      HE THONG DO KHOANG CACH & CANH BAO      \r\n");
    uart_print("==============================================\r\n");

    while (1) {
        volatile uint32_t count = 0;
        volatile int timeout = 200000;

        neorv32_gpio_pin_set(0, 0);
        for (volatile int i = 0; i < 200; i++) { __asm__ volatile ("nop"); }

        neorv32_gpio_pin_set(0, 1);
        for (volatile int i = 0; i < 500; i++) { __asm__ volatile ("nop"); }
        neorv32_gpio_pin_set(0, 0);

        while (!(neorv32_gpio_port_get() & 0x02)) {
            if (timeout-- <= 0) break;
        }

        if (timeout > 0) {
            while (neorv32_gpio_port_get() & 0x02) {
                count++;
                if (count > 1000000) break; 
            }

            uint32_t distance = count / 110; 

            if (distance > 0 && distance < 400) { 
                uart_print("[*] Khoang cach: ");
                uart_print_int_aligned(distance);
                uart_print(" cm   |   Trang thai: ");

                if (distance < 10) {
                    uart_print("NGUY HIEM (DO)  \r\n");
                    neorv32_gpio_pin_set(1, 1);
                    neorv32_gpio_pin_set(2, 0);
                    neorv32_gpio_pin_set(3, 0);
                } else if (distance <= 30) {
                    uart_print("CANH BAO  (VANG)\r\n");
                    neorv32_gpio_pin_set(1, 0);
                    neorv32_gpio_pin_set(2, 1);
                    neorv32_gpio_pin_set(3, 0);
                } else {
                    uart_print("AN TOAN   (XANH)\r\n");
                    neorv32_gpio_pin_set(1, 0);
                    neorv32_gpio_pin_set(2, 0);
                    neorv32_gpio_pin_set(3, 1);
                }
            } else {
                uart_print("[!] Ngoai pham vi do!                         \r\n");
                neorv32_gpio_pin_set(1, 0);
                neorv32_gpio_pin_set(2, 0);
                neorv32_gpio_pin_set(3, 0);
            }
        } else {
            uart_print("[!] Loi: Khong nhan duoc tin hieu Echo!       \r\n");
            neorv32_gpio_pin_set(1, 0);
            neorv32_gpio_pin_set(2, 0);
            neorv32_gpio_pin_set(3, 0);
        }

        // Delay ~500ms
        for (volatile int i = 0; i < 3000000; i++) { __asm__ volatile ("nop"); }
    }
    return 0;
}
