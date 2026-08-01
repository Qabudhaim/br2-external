################################################################################
#
# host-go-toolchain
#
################################################################################

HOST_GO_TOOLCHAIN_VERSION = 1.22.2
HOST_GO_TOOLCHAIN_SITE = https://go.dev/dl
HOST_GO_TOOLCHAIN_SOURCE = go$(HOST_GO_TOOLCHAIN_VERSION).linux-amd64.tar.gz

define HOST_GO_TOOLCHAIN_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/go-$(HOST_GO_TOOLCHAIN_VERSION)
	tar -C $(HOST_DIR)/go-$(HOST_GO_TOOLCHAIN_VERSION) \
		--strip-components=1 \
		-xzf $(HOST_GO_TOOLCHAIN_DL_DIR)/$(HOST_GO_TOOLCHAIN_SOURCE)
endef

$(eval $(host-generic-package))