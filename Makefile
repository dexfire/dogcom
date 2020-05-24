CC     			= clang
TARGET 			= dogcom
INSTALL_DIR 	= /usr/bin/
win32  			:= y
test   			:= n
LNFLAGS 		:= -lws2_32

ifeq ($(debug), y)
	CFLAGS += -DDEBUG -g
endif

ifeq ($(win32), y)
	# CFLAGS += -lws2_32
	CFLAGS += --target=x86_64-w64-mingw32 -Wno-error
	CFLAGS += -IC:\Software\LLVM\x86_64-w64-mingw32\include
	TARGET = dogcom.exe
endif

ifeq ($(static), y)
	CFLAGS += -static
endif

ifeq ($(strip), y)
	CFLAGS += -Os -s -Wno-unused-result -l
endif

ifeq ($(force_encrypt), y)
	CFLAGS += -DFORCE_ENCRYPT
endif

ifeq ($(test), y)
	CFLAGS += -std=gnu99 -DTEST
else
	CFLAGS += -std=gnu99
endif

SOURCES = $(wildcard *.c) $(wildcard libs/*.c)
OBJS    = $(patsubst %.c, %.o, $(SOURCES))

$(TARGET):	$(OBJS)
	$(CC) $(DEBUG) $(TEST) $(OBJS) $(CFLAGS) $(LNFLAGS) -o $(TARGET)

all:	$(TARGET)

install:	$(TARGET)
	cp $(TARGET) $(INSTALL_DIR)

clean:
ifeq ($(win32), y)
	del /q $(subst /,\,$(OBJS))
	del /q $(subst /,\,$(TARGET))
else
	rm -f $(OBJS)
	rm -f $(TARGET)
endif

distclean:  clean

.PHONY: all clean distclean install
