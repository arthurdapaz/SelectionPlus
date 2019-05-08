#include "SelectionPlusPrefsRootListController.h"
#import <spawn.h>

@implementation SelectionPlusPrefsRootListController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(respring)];
    self.navigationItem.rightBarButtonItem = applyButton;
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

- (id)readPreferenceValue:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:path];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:path];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:path atomically:YES];
	CFStringRef notificationName = (CFStringRef)specifier.properties[@"PostNotification"];
	if (notificationName) {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, NULL, NULL, YES);
	}
}

-(void)paypal {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.paypal.me/virindh"] options:@{} completionHandler:nil];
}

-(void)sourceCode {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://github.com/satvikb/SelectionPlus"] options:@{} completionHandler:nil];
}

-(void)credits {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Credits" message:@"u/SatvikbDev\nu/NepetaDev\nu/NoisyFlake\nu/ebaad1009\nu/Altec2001" preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:nil];
  [alert addAction:doneAction];
  [self presentViewController:alert animated:YES completion:nil];
}

-(void)todo {
  vc = [[UIViewController alloc] init];
  UIWebView* webView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
  // webView.delegate = self
  [vc.view addSubview:webView];

  navigation = [[UINavigationController alloc] initWithRootViewController:vc];

  UIBarButtonItem *exitButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissNavigation)];
  vc.navigationItem.leftBarButtonItem = exitButton;

  NSString *urlString = @"http://www.satvik.co/SelectionPlusTodo.html";
  NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
  [webView loadRequest:urlRequest];

  [self presentViewController:navigation animated:YES completion:nil];
}

-(void) dismissNavigation{
  [navigation dismissViewControllerAnimated:YES completion: nil];
}

-(void)respring {
	pid_t pid;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

-(void)resetSettings {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Do you want to reset all settings to their default values?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:@"/var/mobile/Library/Preferences/com.satvikb.selectionplusprefs.plist" error:nil];

        [self respring];
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];

    [alert addAction:noAction];
    [alert addAction:yesAction];

    [self presentViewController:alert animated:YES completion:nil];
}

@end

@implementation SelectionPlusLogo

- (id)initWithSpecifier:(PSSpecifier *)specifier
{
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Banner" specifier:specifier];
	if (self) {
		CGFloat width = 320;
		CGFloat height = 70;

		CGRect backgroundFrame = CGRectMake(-50, -35, width+50, height);
		background = [[UILabel alloc] initWithFrame:backgroundFrame];
		[background layoutIfNeeded];
		background.backgroundColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1.0];
		background.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

		CGRect tweakNameFrame = CGRectMake(0, -40, width, height);
		tweakName = [[UILabel alloc] initWithFrame:tweakNameFrame];
		[tweakName layoutIfNeeded];
		tweakName.numberOfLines = 1;
		tweakName.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		tweakName.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40.0f];
		tweakName.textColor = [UIColor whiteColor];
		tweakName.text = @"SelectionPlus";
		tweakName.textAlignment = NSTextAlignmentCenter;

		CGRect versionFrame = CGRectMake(0, -5, width, height);
		version = [[UILabel alloc] initWithFrame:versionFrame];
		version.numberOfLines = 1;
		version.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		version.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
		version.textColor = [UIColor whiteColor];
		version.text = @"Version 1.0 Beta";
		version.backgroundColor = [UIColor clearColor];
		version.textAlignment = NSTextAlignmentCenter;

		[self addSubview:background];
		[self addSubview:tweakName];
		[self addSubview:version];
	}
    return self;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)width {
	return 100.0f;
}

@end
