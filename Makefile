include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SelectionPlus
SelectionPlus_FILES = selectionplusprefs/UIColor.m Tweak.xm
SelectionPlus_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk


SUBPROJECTS += selectionplusprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
