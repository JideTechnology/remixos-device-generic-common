#
# Copyright (C) 2014-2015 The Android-x86 Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#

LOCAL_PATH := $(my-dir)

SYMLINKS := $(addprefix $(TARGET_OUT)/lib,$(subst $(LOCAL_PATH),,$(shell find $(LOCAL_PATH)/firmware -type l)))

$(SYMLINKS): FW_PATH := $(LOCAL_PATH)
$(SYMLINKS):
	@link_to=`readlink $(subst $(TARGET_OUT)/lib,$(FW_PATH),$@)`; \
	echo "Symlink: $@ -> $$link_to"; \
	mkdir -p $(@D); ln -sf $$link_to $@

ALL_DEFAULT_INSTALLED_MODULES += $(SYMLINKS)

include $(call all-makefiles-under,$(LOCAL_PATH))
