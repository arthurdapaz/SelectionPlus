include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SelectionPlus
SelectionPlus_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk


SUBPROJECTS += selectionplusprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
