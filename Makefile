export ARCHS = armv7 arm64
export TARGET = iphone:clang:latest:latest

PACKAGE_VERSION = 0.0.1

include theos/makefiles/common.mk

TWEAK_NAME = DarkAuxo
DarkAuxo_FILES = Tweak.xm
DarkAuxo_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
