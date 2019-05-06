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
    
    MenuControllerSupportingView *myTextView = [[MenuControllerSupportingView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    //some other setup like setting the font for the UITextView...
    [self.view addSubview:myTextView];
    [myTextView becomeFirstResponder];
    [self.view becomeFirstResponder];

    UIMenuController *menuController = [UIMenuController sharedMenuController];
    UIMenuItem *listMenuItem = [[UIMenuItem alloc] initWithTitle:@"List" action:@selector(addList)];
    
    [menuController setMenuItems:[NSArray arrayWithObject:listMenuItem]];
    [menuController setTargetRect:CGRectMake(50.0, 50.0, 0, 0) inView:self.view];
    [menuController setMenuVisible:YES animated:YES];
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

