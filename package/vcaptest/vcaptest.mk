################################################################################
#
# vcaptest
#
################################################################################

VCAPTEST_VERSION = origin/master
#VCAPTEST_VERSION = 1.0
VCAPTEST_SITE_METHOD = git
VCAPTEST_SITE = git@10.0.10.10:hongliang.duan/demo.git
VCAPTEST_SOURCE = vcaptest-$(VCAPTEST_VERSION).tar.gz
#VCAPTEST_SOURCE = demo/vcaptest
#VCAPTEST_SITE = $(TOPDIR)/gpt/vcaptest
#VCAPTEST_SITE_METHOD = local
VCAPTEST_ALWAYS_BUILD = YES
VCAPTEST_INSTALL_STAGING = YES


VCAPTEST_MAKE_FLAGS += \
	AR=$(TARGET_AR) \
	CC=$(TARGET_CC) \
	TARGET_DIR=$(TARGET_DIR)


define VCAPTEST_BUILD_CMDS
	$(MAKE) $(TARGET_MAKE_ENV) clean -C $(@D)
	$(MAKE) $(TARGET_CONFIGURE_OPTS) $(VCAPTEST_MAKE_FLAGS) -C $(@D)
endef

define VCAPTEST_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/vcap_test/vcaptest $(HOST_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/vcap_test/vcaptest $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
