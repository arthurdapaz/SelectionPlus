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
    
    UITextView *myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //some other setup like setting the font for the UITextView...
    [self.view addSubview:myTextView];
    myTextView.text = @"some text";

    [myTextView becomeFirstResponder];
    [self.view becomeFirstResponder];

    UIMenuController *menuController = [UIMenuController sharedMenuController];
    UIMenuItem *listMenuItem = [[UIMenuItem alloc] initWithTitle:@"List" action:@selector(addList)];
    UIMenuItem *listMenuItem2 = [[UIMenuItem alloc] initWithTitle:@"Long Action name 1" action:@selector(addList)];
    UIMenuItem *listMenuItem3 = [[UIMenuItem alloc] initWithTitle:@"Long Action name 2" action:@selector(addList)];
    UIMenuItem *listMenuItem4 = [[UIMenuItem alloc] initWithTitle:@"Long Action name 3" action:@selector(addList)];
    UIMenuItem *listMenuItem5 = [[UIMenuItem alloc] initWithTitle:@"Long Action name 4" action:@selector(addList)];
    UIMenuItem *listMenuItem6 = [[UIMenuItem alloc] initWithTitle:@"Long Action name 5" action:@selector(addList)];

    [menuController setMenuItems:[NSArray arrayWithObjects:listMenuItem, listMenuItem2, listMenuItem3, listMenuItem4, listMenuItem5, listMenuItem6, nil]];
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

