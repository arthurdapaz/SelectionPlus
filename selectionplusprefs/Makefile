include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SelectionPlusPrefs
SelectionPlusPrefs_FILES = UIColor.m SelectionPlusPrefsRootListController.m ColorPickerCell.m
SelectionPlusPrefs_INSTALL_PATH = /Library/PreferenceBundles
SelectionPlusPrefs_FRAMEWORKS = UIKit
SelectionPlusPrefs_PRIVATE_FRAMEWORKS = Preferences
SelectionPlusPrefs_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SelectionPlusPrefs.plist$(ECHO_END)
