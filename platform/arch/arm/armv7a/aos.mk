NAME := armv7a

$(NAME)_MBINS_TYPE := kernel
$(NAME)_VERSION    := 0.0.1.0
$(NAME)_SUMMARY    := arch for armv7a

$(NAME)_SOURCES := common/k_vector.c
$(NAME)_SOURCES += common/k_cache.c
$(NAME)_SOURCES += common/k_mmu_sd.c
$(NAME)_SOURCES += common/panic.c
GLOBAL_INCLUDES += common

ifeq ($(COMPILER),armcc)

$(NAME)_SOURCES += common/k_cache_armcc.S

ifeq ($(HOST_ARCH),Cortex-A5)
$(NAME)_SOURCES += armcc/a5/port_s.S
$(NAME)_SOURCES += armcc/a5/vector_s.S
$(NAME)_SOURCES += armcc/a5/port_c.c
GLOBAL_INCLUDES += armcc/a5
else ifeq ($(HOST_ARCH),Cortex-A7)
$(NAME)_SOURCES := panic/panic_c.c
$(NAME)_SOURCES += armcc/a7/port_s.S
$(NAME)_SOURCES += armcc/a7/port_c.c
GLOBAL_INCLUDES += armcc/a7
else ifeq ($(HOST_ARCH),Cortex-A9)
$(NAME)_SOURCES += armcc/a9/port_s.S
$(NAME)_SOURCES += armcc/a9/vector_s.S
$(NAME)_SOURCES += armcc/a9/port_c.c
GLOBAL_INCLUDES += armcc/a9
endif

else ifeq ($(COMPILER),iar)

$(NAME)_SOURCES += common/k_cache_iccarm.S

ifeq ($(HOST_ARCH),Cortex-A5)
$(NAME)_SOURCES += iccarm/a5/port_s.S
$(NAME)_SOURCES += iccarm/a5/vector_s.S
$(NAME)_SOURCES += iccarm/a5/port_c.c
GLOBAL_INCLUDES += iccarm/a5
else ifeq ($(HOST_ARCH),Cortex-A7)
$(NAME)_SOURCES := panic/panic_c.c
$(NAME)_SOURCES += iccarm/a7/port_s.S
$(NAME)_SOURCES += iccarm/a7/port_c.c
GLOBAL_INCLUDES += iccarm/a7
else ifeq ($(HOST_ARCH),Cortex-A9)
$(NAME)_SOURCES += iccarm/a9/port_s.S
$(NAME)_SOURCES += iccarm/a9/vector_s.S
$(NAME)_SOURCES += iccarm/a9/port_c.c
GLOBAL_INCLUDES += iccarm/a9
endif

else

$(NAME)_SOURCES += common/k_cache_gcc.S

ifeq ($(HOST_ARCH),Cortex-A5)
$(NAME)_SOURCES += gcc/a5/port_s.S
$(NAME)_SOURCES += gcc/a5/vector_s.S
$(NAME)_SOURCES += gcc/a5/port_c.c
GLOBAL_INCLUDES += gcc/a5
else ifeq ($(HOST_ARCH),Cortex-A7)
$(NAME)_SOURCES := panic/panic_c.c
$(NAME)_SOURCES += gcc/a7/port_s.S
$(NAME)_SOURCES += gcc/a7/port_c.c
GLOBAL_INCLUDES += gcc/a7
else ifeq ($(HOST_ARCH),Cortex-A9)
ifeq ($(ENABLE_USPACE),1)
$(NAME)_SOURCES += gcc/syscall/a9/port_s.S
$(NAME)_SOURCES += gcc/syscall/a9/vector_s.S
$(NAME)_SOURCES += gcc/syscall/a9/port_c.c
$(NAME)_SOURCES += gcc/syscall/svc/svc.S
GLOBAL_INCLUDES += gcc/syscall/a9
GLOBAL_INCLUDES += gcc/syscall/include
else
$(NAME)_SOURCES += gcc/a9/port_s.S
$(NAME)_SOURCES += gcc/a9/vector_s.S
$(NAME)_SOURCES += gcc/a9/port_c.c
GLOBAL_INCLUDES += gcc/a9
endif
endif

endif