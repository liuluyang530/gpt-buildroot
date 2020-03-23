################################################################################
#
# fbplay
#
################################################################################

FBPLAY_VERSION = 1.0
FBPLAY_SOURCE = fbplay
FBPLAY_SITE = $(TOPDIR)/gpt/fbplay
FBPLAY_SITE_METHOD = local
FBPLAY_INSTALL_STAGING = YES

FBPLAY_DEPENDENCIES += ffmpeg-gpt host-pkgconf

FBPLAY_MAKE_FLAGS += \
	AR=$(TARGET_AR) \
	CC=$(TARGET_CC) \
	TARGET_DIR=$(TARGET_DIR)


define FBPLAY_BUILD_CMDS
	$(MAKE) $(TARGET_MAKE_ENV) clean -C $(@D)
	$(MAKE) $(TARGET_CONFIGURE_OPTS) $(FBPLAY_MAKE_FLAGS) -C $(@D)
endef

define FBPLAY_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/fbplay $(HOST_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/fbplay $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
