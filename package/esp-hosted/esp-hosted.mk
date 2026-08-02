################################################################################
#
# esp-hosted
#
################################################################################

ESP_HOSTED_VERSION = 8626b42
ESP_HOSTED_SITE = https://github.com/espressif/esp-hosted.git
ESP_HOSTED_SITE_METHOD = git

ESP_HOSTED_MODULE_DIR = esp_hosted_ng/host

define ESP_HOSTED_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		target=spi \
		ARCH=$(KERNEL_ARCH) \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		KERNEL=$(TOPDIR)/../../objs_kernel \
		-C $(@D)/$(ESP_HOSTED_MODULE_DIR)
endef

define ESP_HOSTED_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 \
		$(@D)/$(ESP_HOSTED_MODULE_DIR)/esp32_spi.ko \
		$(TARGET_DIR)/lib/modules/extra/esp32_spi.ko

	$(INSTALL) -D -m 0755 \
		$(ESP_HOSTED_PKGDIR)/wifi-action.sh \
		$(TARGET_DIR)/usr/bin/wifi-action.sh
endef

define ESP_HOSTED_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 \
		$(ESP_HOSTED_PKGDIR)/S99esp-hosted \
		$(TARGET_DIR)/etc/init.d/S99esp-hosted
endef

$(eval $(generic-package))
