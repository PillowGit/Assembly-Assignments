#include <iostream>
#include <cstdint>

inline uint64_t get_tics() {
  uint64_t tsc;
  asm volatile ("rdtsc" : "=A" (tsc));
  return tsc;
}

int main() {
	std::cout << get_tics() << std::endl;
	return 0;
}
