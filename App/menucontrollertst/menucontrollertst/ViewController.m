//
//  ViewController.m
//  menucontrollertst
//
//  Created by Satvik Borra on 5/3/19.
//  Copyright © 2019 satvik borra. All rights reserved.
//

#import "ViewController.h"


@interface MenuControllerSupportingView : UIView
{
    
}
@end

@implementation MenuControllerSupportingView

//It's mandatory and it has to return YES then only u can show menu items..
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextView *myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //some other setup like setting the font for the UITextView...
    [self.view addSubview:myTextView];
    myTextView.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vel sem finibus, auctor massa finibus, semper nibh. Integer mollis convallis elit a facilisis. Duis venenatis nibh purus, vel auctor urna aliquam eget. Maecenas id magna quis lorem tempus dignissim a ac orci. Suspendisse non sagittis arcu, et luctus lorem. Ut sit amet lacus fermentum, dictum elit nec, consectetur sapien. Praesent et libero mattis, pharetra libero non, ornare augue. Morbi at mollis turpis. Nullam eget rhoncus est, vitae laoreet enim. Phasellus rutrum tristique nulla quis varius. Donec nisl enim, sodales sit amet aliquet a, mattis id risus. Curabitur suscipit, diam sed luctus gravida, leo tellus dictum tortor, vel fringilla elit nisi eu nunc. Maecenas ut arcu eleifend, faucibus enim id, euismod eros. Suspendisse potenti. Phasellus condimentum vestibulum turpis.";

    [myTextView becomeFirstResponder];
    [self.view becomeFirstResponder];

    UIMenuController *menuController = [UIMenuController sharedMenuController];
//    UIMenuItem *listMenuItem = [[UIMenuItem alloc] initWithTitle:@"List" action:@selector(addList)];
    UIMenuItem *listMenuItem2 = [[UIMenuItem alloc] initWithTitle:@"Long Button Text For Demonstration Purposes" action:@selector(addList)];
//    UIMenuItem *listMenuItem3 = [[UIMenuItem alloc] initWithTitle:@"Long Action name 2" action:@selector(addList)];
//    UIMenuItem *listMenuItem4 = [[UIMenuItem alloc] initWithTitle:@"Long Action name 3" action:@selector(addList)];
//    UIMenuItem *listMenuItem5 = [[UIMenuItem alloc] initWithTitle:@"Long Action name 4" action:@selector(addList)];
//    UIMenuItem *listMenuItem6 = [[UIMenuItem alloc] initWithTitle:@"Long Action name 5" action:@selector(addList)];

    [menuController setMenuItems:[NSArray arrayWithObjects: listMenuItem2, nil]];
//    [menuController setTargetRect:CGRectMake(50.0, 50.0, 0, 0) inView:self.view];
//    [menuController setMenuVisible:YES animated:YES];
    NSLog(@"init");
    [self.view becomeFirstResponder];
    
}

-(void)addList{
    NSLog(@"list");
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

@end

