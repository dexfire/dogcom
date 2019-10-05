LOCAL_PATH := $(call my-dir)
  
include $(CLEAR_VARS)
 
LOCAL_MODULE := dogcom
LOCAL_SRC_FILES := main.c auth.c configparse.c daemon.c eapol.c keepalive.c \
	 libs/sha1.c libs/common.c libs/md4.c libs/md5.c
	
# $(wildcard *.c) $(wildcard libs/*.c)
# APP_PLATFORM := 16

include $(BUILD_EXECUTABLE)
