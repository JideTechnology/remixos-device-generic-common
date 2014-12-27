#
# Copyright (C) 2012 The Android-x86 Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#

LOCAL_FIRMWARES_DIR ?= device/generic/common/firmware
LOCAL_FIRMWARES ?= $(filter-out %.mk,$(subst $(LOCAL_FIRMWARES_DIR)/,,$(shell find $(LOCAL_FIRMWARES_DIR) -type f)))

PRODUCT_COPY_FILES := \
    $(foreach f,$(LOCAL_FIRMWARES),$(LOCAL_FIRMWARES_DIR)/$(f):system/lib/firmware/$(f))
