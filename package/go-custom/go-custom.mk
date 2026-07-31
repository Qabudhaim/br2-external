HOST_GO_CUSTOM_VERSION = 1.22.2
HOST_GO_CUSTOM_SITE = https://go.dev/dl
HOST_GO_CUSTOM_SOURCE = go$(HOST_GO_CUSTOM_VERSION).linux-amd64.tar.gz

define HOST_GO_CUSTOM_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/go-custom
	tar -C $(HOST_DIR)/go-custom \
		--strip-components=1 \
		-xzf $(HOST_GO_CUSTOM_DL_DIR)/$(HOST_GO_CUSTOM_SOURCE)
endef

$(eval $(host-generic-package))
