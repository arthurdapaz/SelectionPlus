#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

@interface SelectionPlusPrefsRootListController : PSListController{
	UINavigationController *navigation;
	UIViewController* vc;
}
@end

@interface SelectionPlusLogo : PSTableCell {
	UILabel *background;
	UILabel *tweakName;
	UILabel *version;
}

@end
