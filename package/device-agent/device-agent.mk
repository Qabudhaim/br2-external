################################################################################
#
# device-agent
#
################################################################################

DEVICE_AGENT_VERSION = 9c5df14
DEVICE_AGENT_SITE = https://github.com/Qabudhaim/device-agent.git
DEVICE_AGENT_SITE_METHOD = git

DEVICE_AGENT_LICENSE = MIT
DEVICE_AGENT_LICENSE_FILES = LICENSE

DEVICE_AGENT_DEPENDENCIES = host-go-toolchain

define DEVICE_AGENT_BUILD_CMDS
	cd $(@D) && \
	PATH=$(HOST_DIR)/go-$(HOST_GO_TOOLCHAIN_VERSION)/bin:$(PATH) \
	GOOS=linux \
	GOARCH=arm \
	CC="$(TARGET_CC)" \
	CGO_ENABLED=1 \
	GOCACHE=$(@D)/.gocache \
	go build \
		-trimpath \
		-ldflags="-s -w" \
		-o $(@D)/device-agent \
		.
endef

define DEVICE_AGENT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 \
		$(@D)/device-agent \
		$(TARGET_DIR)/usr/bin/device-agent
endef

define DEVICE_AGENT_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 \
		$(DEVICE_AGENT_PKGDIR)/S101device-agent \
		$(TARGET_DIR)/etc/init.d/S101device-agent
endef

$(eval $(generic-package))
