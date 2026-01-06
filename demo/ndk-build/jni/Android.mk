LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := demo-ndk-build

LOCAL_SRC_FILES := main.cpp

include $(BUILD_EXECUTABLE)
