ifneq ($(filter $(strip $(HOUDINI_HOST_ARCH)),x86 x86_64),$(HOUDINI_HOST_ARCH))
    $(error must defined HOUDINI_HOST_ARCH to one of (x86, x86_64) before including houdini.mk)
endif

HOUDINI := houdini_$(strip $(HOUDINI_HOST_ARCH))_arm
HOUDINI64 := houdini_x86_64_arm64

$(info $(LOCAL_PATH))

ifeq ($(strip $(HOUDINI_PREINSTALL)),true)
    LOCAL_HOUDINI_PATH := device/generic/common/houdini
    LOCAL_HOUDINI_LIB_PATH := $(LOCAL_HOUDINI_PATH)/$(HOUDINI)

    LOCAL_HOUDINI_LIB += $(subst $(LOCAL_HOUDINI_LIB_PATH)/,,$(shell find $(LOCAL_HOUDINI_LIB_PATH)/ -type f))
    PRODUCT_COPY_FILES += $(foreach f,$(LOCAL_HOUDINI_LIB),$(LOCAL_HOUDINI_LIB_PATH)/$(f):system/lib/arm/$(f))

    ifeq ($(strip $(HOUDINI_HOST_ARCH)),x86_64)

        LOCAL_HOUDINI_LIB_PATH := $(LOCAL_HOUDINI_PATH)/$(HOUDINI64)
        LOCAL_HOUDINI_LIB += $(subst $(LOCAL_HOUDINI_LIB_PATH)/,,$(shell find $(LOCAL_HOUDINI_LIB_PATH)/ -type f))
        PRODUCT_COPY_FILES += $(foreach f,$(LOCAL_HOUDINI_LIB),$(LOCAL_HOUDINI_LIB_PATH)/$(f):system/lib64/arm64/$(f))

    endif

    PRODUCT_PROPERTY_OVERRIDES += \
        persist.sys.nativebridge=1

else

    PRODUCT_COPY_FILES += \
        device/generic/common/houdini/$(HOUDINI).tgz:system/etc/houdini.tgz \

    ifeq ($(strip $(HOUDINI_HOST_ARCH)),x86_64)

        PRODUCT_COPY_FILES += \
            device/generic/common/houdini/$(HOUDINI64).tgz:system/etc/houdini64.tgz \

    endif

endif
