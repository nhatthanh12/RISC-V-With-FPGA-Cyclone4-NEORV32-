#include <stddef.h>

// Thay thế cho strlen
size_t strlen(const char *s) {
    size_t len = 0;
    while (*s++) len++;
    return len;
}

// Thay thế cho memcpy
void *memcpy(void *dest, const void *src, size_t n) {
    char *d = dest;
    const char *s = src;
    while (n--) *d++ = *s++;
    return dest;
}

// Xử lý lỗi _ctype_ (cho tolower/isupper)
// Đây là bảng tra cứu tối giản cho ký tự ASCII
const char _ctype_b_data[257] = { 0 }; 
const char *__ctype_ptr__ = _ctype_b_data + 1;
const char _ctype_[257] = { 0 };