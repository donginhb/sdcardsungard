#ifndef _KSCARD_VERSION_H_
#define _KSCARD_VERSION_H_

#define _KSCARD_VER_MAJOR 3
#define _KSCARD_VER_MINOR 3
#define _KSCARD_VER_BUILD 21
#define KSG_STRINGIFY(n) KSG_STRINGIFY_HELPER(n)
#define KSG_STRINGIFY_HELPER(n) #n

#define KSCARD_VERSION KSG_STRINGIFY(_KSCARD_VER_MAJOR) "." \
	KSG_STRINGIFY(_KSCARD_VER_MINOR) "." \
	KSG_STRINGIFY(_KSCARD_VER_BUILD)

#endif // _KSCARD_VERSION_H_
