#include "SigScan.h"
#include "helpers.h"

SIG_SCAN (sigBitTest, 0x1503CDCA8, "\x46\x8B\x4C\x83\x00\x41\x0F\x92\xD2", "xxxx?xxxx");
SIG_SCAN (sigSetBigger, 0x14025496F, "\x83\xF9\x02\x0F\x97\xC0", "xxxxxx");

#ifdef __cplusplus
extern "C" {
#endif
__declspec (dllexport) void PreInit () {
	WRITE_MEMORY ((u64)sigBitTest () + 5, u8, 0x41, 0xB2, 0x01, 0x90);
	WRITE_MEMORY ((u64)sigSetBigger () + 3, u8, 0xB0, 0x01, 0x90);
}
#ifdef __cplusplus
}
#endif
