/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/

#import "headers.h"
//
// %hook UIMenuController
// -(id)init{
//   HBLogDebug(@"Menu");
//   return %orig;
// }
//
// -(bool)isMenuVisible{
//   HBLogDebug(@"Menu2 %i", %orig);
//
//   return %orig;
// }
//
// -(void)update{
//   HBLogDebug(@"Menu3");
//   %orig;
// }
//
// -(CGRect)menuFrame{
//   HBLogDebug(@"Menu4 %@", NSStringFromCGRect(%orig));
//   CGRect r = %orig;
//   return CGRectMake(r.origin.x, r.origin.y+200, r.size.width, r.size.height*4);
// }
//
// -(void)setMenuVisible:(bool)arg1 animated:(bool)arg2{
//   HBLogDebug(@"vis %i", arg1);
//
//   %orig;
// }
//
// -(void)_setTargetRect:(CGRect)arg1 inView:(id)arg2 animated:(bool)arg3{
//   HBLogDebug(@"TR2");
//   %orig;
// }
//
// -(void)setTargetRect:(CGRect)arg1 inView:(id)arg2{
//     HBLogDebug(@"TR");
//     %orig;
// }
//
// +(id)sharedMenuController{
//   UIMenuController *o = %orig;
//
//   UIView* targetView = MSHookIvar<UIView *>(o, "_targetView");
//   targetView.layer.borderWidth = 3;
//   targetView.layer.borderColor = UIColor.blueColor.CGColor;
//
//   // HBLogDebug(@"Shared %@ %@ %@", NSStringFromCGRect(o.menuFrame), NSStringFromCGRect(targetView.frame), [o description]);
//   HBLogDebug(@"Shared %@ %@", NSStringFromCGRect(o.menuFrame), NSStringFromCGRect(targetView.frame));
//
//   [o update];
//   return o;
// }
// %end
//
// %hook UIMenuItem
// -(id)initWithTitle:(id)arg1 action:(SEL)arg2{
//   HBLogDebug(@"Menu Item init %@", arg1);
//   return %orig;
// }
// %end
//
// %hook UICalloutBar
// -(id)initWithFrame:(CGRect)arg1{
//   UICalloutBar* bc = %orig;
//   HBLogDebug(@"Calloutbar init %@ %lu", NSStringFromCGRect(arg1), (long)bc.subviews.count);
//   // UIView* sub = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//   // sub.backgroundColor = UIColor.yellowColor;
//   // sub.tag = 1020;
//   // [bc addSubview: sub];
//   // bc.clipsToBounds = true;
//   // bc.isDisplayingVertically = true;
//   // MSHookIvar<bool>(bc, "m_isDisplayingVertically") = true;
//   for(UIView* sub in bc.subviews){
//     HBLogDebug(@"SUB DESC: %@", [sub description]);
//   }
//   // HBLogDebug(@"L %@ R %@ T %@ B %@", NSStringFromCGPoint(bc.pointLeftOfControls), NSStringFromCGPoint(bc.pointRightOfControls), NSStringFromCGPoint(bc.pointAboveControls), NSStringFromCGPoint(bc.pointBelowControls));
//   return bc;
// }
// //
// // -(bool)isDisplayingVertically{
// //   return YES;
// // }
//
// +(void)fadeSharedCalloutBar{
//   HBLogDebug(@"fade");
//   %orig;
// }
//
// +(id)sharedCalloutBar{
//   // HBLogDebug(@"Sha CB");
//   return %orig;
// }
//
// -(void)configureButtons:(double)arg1{
//   HBLogDebug(@"config btn %f", arg1);
//   %orig;
//
// }
//
// - (void)buttonHighlighted:(id)arg1 highlighted:(bool)arg2{
//   HBLogDebug(@"HIGHLIHGT disable %i", arg2);
// }
//
// -(bool)setFrameForSize:(CGSize)arg1{
//   HBLogDebug(@"frame from Size %@", NSStringFromCGSize(arg1));
//   return %orig;//(CGSizeMake(arg1.width*1.1, arg1.height*1.1));
// }
//
// - (void)didAddSubview:(UIView *)subview{
//   HBLogDebug(@"Sub %@", [subview description]);
//   %orig;
// }
//
// -(void)setPointBelowControls:(CGPoint)arg1{
//   HBLogDebug(@"B %@", NSStringFromCGPoint(arg1));
//   %orig;
// }
// -(void)setPointAboveControls:(CGPoint)arg1{
//   HBLogDebug(@"A %@", NSStringFromCGPoint(arg1));
//   %orig;
// }
// -(void)setPointLeftOfControls:(CGPoint)arg1{
//   HBLogDebug(@"L %@", NSStringFromCGPoint(arg1));
//   %orig;
// }
// -(void)setPointRightOfControls:(CGPoint)arg1{
//   HBLogDebug(@"R %@", NSStringFromCGPoint(arg1));
//   %orig;
// }
//
// -(void)update{
//   HBLogDebug(@"UP");
//   %orig;
// }
//
// -(void)appear{
//   HBLogDebug(@"App");
//   %orig;
// }
// %end

// %hook UIView
// -(id)hitTest:(CGPoint)arg1 withEvent:(id)arg2{
//   if([self isMemberOfClass:%c(UICalloutBar)]){
//     NSLog(@"UICALLOUT HIT TEST %@", NSStringFromCGPoint(arg1));
//   }
//   return %orig;
// }
//
// - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//   if([self isMemberOfClass:%c(UICalloutBar)]){
//     NSLog(@"TOUCHES BEGIN set 2 %@", NSStringFromCGPoint([[[event allTouches] anyObject] locationInView: self]));
//   }
//   %orig;
// }
// %end



%hook UICalloutBar
// - (void)setPointAboveControls:(CGPoint)pointAboveControls { %log; %orig; }
// - (CGPoint)pointAboveControls { %log; CGPoint  r = %orig; HBLogDebug(@" = {%g, %g}", r.x, r.y); return r; }
// - (void)setPointBelowControls:(CGPoint)pointBelowControls { %log; %orig; }
// - (CGPoint)pointBelowControls { %log; CGPoint  r = %orig; HBLogDebug(@" = {%g, %g}", r.x, r.y); return r; }
// - (void)setPointLeftOfControls:(CGPoint)pointLeftOfControls { %log; %orig; }
// - (CGPoint)pointLeftOfControls { %log; CGPoint  r = %orig; HBLogDebug(@" = {%g, %g}", r.x, r.y); return r; }
// - (void)setPointRightOfControls:(CGPoint)pointRightOfControls { %log; %orig; }
// - (CGPoint)pointRightOfControls { %log; CGPoint  r = %orig; HBLogDebug(@" = {%g, %g}", r.x, r.y); return r; }
// - (void)setTargetPoint:(CGPoint)targetPoint { %log; %orig; }
// - (CGPoint)targetPoint { %log; CGPoint  r = %orig; HBLogDebug(@" = {%g, %g}", r.x, r.y); return r; }
// - (void)setTargetDirection:(int)targetDirection { %log; %orig; }
// - (int)targetDirection { %log; int  r = %orig; HBLogDebug(@" = %d", r); return r; }
// - (void)setTargetHorizontal:(bool)targetHorizontal {
//   %log;
//   %orig;//(1);
// }
// - (bool)targetHorizontal { %log; bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
// - (void)setTargetRect:(CGRect)targetRect { %log; %orig; }
// - (CGRect)targetRect { %log; CGRect  r = %orig; HBLogDebug(@" = {{%g, %g}, {%g, %g}}", r.origin.x, r.origin.y, r.size.width, r.size.height); return r; }
// - (void)setTargetWindow:(UIWindow*)targetWindow { %log; %orig; }
// - (UIWindow*)targetWindow { %log; UIWindow*  r = %orig; HBLogDebug(@" = %@", r); return r; }
// - (void)setArrowDirection:(int)arrowDirection { %log; %orig; }
// - (int)arrowDirection { %log; int  r = %orig; HBLogDebug(@" = %d", r); return r; }
// - (void)setControlFrame:(CGRect)controlFrame { %log; %orig; }
// - (CGRect)controlFrame { %log; CGRect  r = %orig; HBLogDebug(@" = {{%g, %g}, {%g, %g}}", r.origin.x, r.origin.y, r.size.width, r.size.height); return r; }
// - (void)setCurrentAppearOrFadeContext:(NSDictionary*)currentAppearOrFadeContext { %log; %orig; }
// - (NSDictionary*)currentAppearOrFadeContext { %log; NSDictionary*  r = %orig; HBLogDebug(@" = %@", r); return r; }
// - (void)setSuppressesAppearance:(bool)suppressesAppearance { %log; %orig; }
// - (bool)suppressesAppearance { %log; bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
// - (bool)isDisplayingVertically { %log; bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
// - (UIScrollView*)verticalScrollView { %log; UIScrollView*  r = %orig; HBLogDebug(@" = %@", r); return r; }
// - (UIStackView*)verticalStackView { %log; UIStackView*  r = %orig; HBLogDebug(@" = %@", r); return r; }
// - (NSArray*)rectsToEvade { %log; NSArray*  r = %orig; HBLogDebug(@" = %@", r); return r; }
// - (void)setDelegate:(id)delegate { %log; %orig; }
// - (id)delegate { %log; id  r = %orig; HBLogDebug(@" = %@", r); return r; }
// - (bool)visible { %log; bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
// - (void)setResponderTarget:(UIResponder*)responderTarget { %log; %orig; }
// - (UIResponder*)responderTarget { %log; UIResponder*  r = %orig; HBLogDebug(@" = %@", r); return r; }
// - (void)setReplacements:(NSArray*)replacements { %log; %orig; }
// - (NSArray*)replacements { %log; NSArray*  r = %orig; HBLogDebug(@" = %@", r); return r; }
// - (void)setShowAllReplacements:(bool)showAllReplacements { %log; %orig; }
// - (bool)showAllReplacements { %log; bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
// - (void)setExtraItems:(NSArray*)extraItems { %log; %orig; }
// - (NSArray*)extraItems { %log; NSArray*  r = %orig; HBLogDebug(@" = %@", r); return r; }
// - (void)setUntruncatedString:(NSString*)untruncatedString { %log; %orig; }
// - (NSString*)untruncatedString { %log; NSString*  r = %orig; HBLogDebug(@" = %@", r); return r; }
// - (void)setSupressesHorizontalMovement:(bool)supressesHorizontalMovement { %log; %orig; }
// - (bool)supressesHorizontalMovement { %log; bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
// +(id)activeCalloutBar { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
// +(void)fadeSharedCalloutBar { %log; %orig; }
// +(void)hideSharedCalloutBar { %log; %orig; }
// +(void)performWithoutAffectingSharedCalloutBar:(/*^block*/ id)arg1  { %log; %orig; }
// +(void)_releaseSharedInstance { %log; %orig; }
// +(bool)sharedCalloutBarIsVisible { %log; bool r = %orig; HBLogDebug(@" = %d", r); return r; }
// -(id)initWithFrame:(CGRect)arg1  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
// -(void)removeFromSuperview { %log; %orig; }
// -(void)hide { %log; %orig; }
// -(void)show { %log; %orig; }
// -(void)dealloc { %log; %orig; }
-(id)hitTest:(CGPoint)arg1 withEvent:(id)arg2  {
  // %log;
  // id r = %orig;
  // HBLogDebug(@" HIT TEST = %@", r);
  // return r;

  if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
      return nil;
  }
  if ([self pointInside:arg1 withEvent:arg2]) {
      for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
          CGPoint convertedPoint = [subview convertPoint:arg1 fromView:self];
          UIView *hitTestView = [subview hitTest:convertedPoint withEvent:arg2];
          if (hitTestView) {
              return hitTestView;
          }
      }
      return self;
  }
  return nil;
}

// -(bool)pointInside:(CGPoint)arg1 withEvent:(id)arg2  { %log; bool r = %orig; HBLogDebug(@"POINT INSIDE %@ = %d", NSStringFromCGPoint(arg1), r); return r; }
// -(bool)_touchesInsideShouldHideCalloutBar { %log; bool r = %orig; HBLogDebug(@" = %d", r); return r; }
// -(void)fade { %log; %orig; }
// -(void)update { %log; %orig; }
// -(void)clearSupressesHorizontalMovementFrame { %log; %orig; }
// -(int)textEffectsVisibilityLevel { %log; int r = %orig; HBLogDebug(@" = %d", r); return r; }
// -(bool)hasReplacements { %log; bool r = %orig; HBLogDebug(@" = %d", r); return r; }
// -(bool)recentlyFaded { %log; bool r = %orig; HBLogDebug(@" = %d", r); return r; }
// -(void)clearEvadeRects { %log; %orig; }
// -(void)addRectToEvade:(CGRect)arg1  { %log; %orig; }
// -(void)setTargetRect:(CGRect)arg1 view:(id)arg2 pointBelowControls:(CGPoint)arg3 pointAboveControls:(CGPoint)arg4  { %log; %orig; }
// -(void)appear { %log; %orig; }
// -(void)clearReplacements { %log; %orig; }
// -(void)buttonHighlighted:(id)arg1 highlighted:(bool)arg2  { %log; %orig; }
// -(void)buttonPressed:(id)arg1  { %log; %orig; }
// -(void)_showPreviousItems:(id)arg1  { %log; %orig; }
// -(void)_showNextItems:(id)arg1  { %log; %orig; }
// -(void)applicationDidAddDeactivationReason:(id)arg1  { %log; %orig; }
// -(id)targetForAction:(SEL)arg1  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
// -(void)_fadeAfterCommand:(SEL)arg1  { %log; %orig; }
// -(bool)_updateVisibleItemsAnimated:(bool)arg1  { %log; bool r = %orig; HBLogDebug(@" = %d", r); return r; }
// -(CGRect)textEffectsWindowSafeArea { %log; CGRect r = %orig; HBLogDebug(@" = {{%g, %g}, {%g, %g}}", r.origin.x, r.origin.y, r.size.width, r.size.height); return r; }
// -(double)supressHorizontalXMovementIfNeededForPoint:(CGPoint)arg1 proposedX:(double)arg2  { %log; double r = %orig; HBLogDebug(@" = %f", r); return r; }
// -(bool)rectClear:(CGRect)arg1  { %log; bool r = %orig; HBLogDebug(@" = %d", r); return r; }
// -(bool)calculateControlFrameInsideTargetRect:(CGSize)arg1  { %log; bool r = %orig; HBLogDebug(@" = %d", r); return r; }
// -(void)updateForCurrentVerticalPage { %log; %orig; }
// -(void)updateForCurrentHorizontalPage { %log; %orig; }
// // -(void)addVerticalSeparatorAfterButton:(id)arg1  { %log; %orig; }
// -(double)maxVerticalCalloutHeightForMinButtonHeight:(double)arg1  { %log; double r = %orig; HBLogDebug(@" = %f", r); return r; }
// -(void)configureButtonsForVerticalView:(double)arg1  { %log; %orig; }
// -(void)configureButtons:(double)arg1  { %log; %orig; }
// -(void)adjustFrameToAvoidDividerOnArrow { %log; %orig; }

float SIZE_WIDTH = 160;
float CELL_HEIGHT = 40;
float MAX_DEFAULT_HEIGHT = 120;
CGSize theSize = CGSizeMake(160, 0);
// int btnCount = 0;

-(bool)setFrameForSize:(CGSize)arg1  {
  %log;
  bool r = %orig(theSize);
  HBLogDebug(@" = %d", r);
  return r;
}

-(bool)calculateControlFrameForCalloutSize:(CGSize)arg1 below:(bool)arg2  {
  %log;
  bool r = %orig(theSize, arg2);
  HBLogDebug(@" = %d", r);
  return r;
}

-(bool)calculateControlFrameForCalloutSize:(CGSize)arg1 right:(bool)arg2  {
  %log;
  bool r = %orig(theSize, arg2);
  HBLogDebug(@" = %d", r);
  return r;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  NSLog(@"TOUCHES BEGIN set %@", NSStringFromCGPoint([[[event allTouches] anyObject] locationInView: self]));
  %orig;
}

+(id)sharedCalloutBar {
  // %log;
  UICalloutBar* r = %orig;
  HBLogDebug(@" = %@", r);

  // NSLog(@"PAGE COUNT %i", MSHookIvar<int>(r, "m_pageCount"));
  // MSHookIvar<int>(r, "m_pageCount") = 1;

  MSHookIvar<UIView *>(r, "m_nextButton").hidden = YES;
  MSHookIvar<UIView *>(r, "m_previousButton").hidden = YES;

  if(viewWithTag(r, 1020) == nil){
    UIScrollView* sub = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, theSize.width, theSize.height)];
    sub.tag = 1020;
    sub.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    r.clipsToBounds = true;
    sub.contentSize = CGSizeMake(theSize.width, theSize.height);

    sub.backgroundColor = [UIColor colorWithRed:14.0/255.0 green:14.0/255.0 blue:14.0/255.0 alpha:0.8];
    sub.layer.cornerRadius = theSize.width*0.05;
    sub.layer.borderWidth = 2;
    sub.layer.borderColor = UIColor.whiteColor.CGColor;
    // sub.backgroundColor = UIColor.clearColor;

    // UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    // UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    // // blurView.translatesAutoresizingMaskIntoConstraints = false
    // blurView.frame = CGRectMake(0, 0, SIZE_WIDTH, MAX_DEFAULT_HEIGHT);
    //
    // [r addSubview:blurView];
    // [r sendSubviewToBack: blurView];

    // [blurView.contentView addSubview: sub];
    // bc.isDisplayingVertically = true;
    // MSHookIvar<bool>(bc, "m_isDisplayingVertically") = true;
    // for(UIView* sub in r.subviews){
    //   if([sub isMemberOfClass:%c(UICalloutBarButton)]){
    //
    //
    //     sub.frame = CGRectMake(0, 40*btnCount, theSize.width, 40);
    //     btnCount += 1;
    //     HBLogDebug(@"SUB DESC: %@ %i", [sub description], btnCount);
    //   }
    // }

    [r addSubview: sub];
  }

  // r.layer.borderColor = UIColor.blueColor.CGColor;
  // r.layer.borderWidth = 3;
  // HBLogDebug(@"PAGES %i", MSHookIvar<int>(r, "m_pageCount"));
  // HBLogDebug(@"SYS BTN DESC %@", MSHookIvar<NSArray*>(r, "m_systemButtonDescriptions"));
  // HBLogDebug(@"CURRENT SYSTEM BTN %@", MSHookIvar<NSMutableArray*>(r, "m_currentSystemButtons"));
  // HBLogDebug(@"EXTRA BTN %@", MSHookIvar<NSMutableArray*>(r, "m_extraButtons"));

  // for(UIView* separatorView in MSHookIvar<NSMutableArray*>(r, "m_axSeparatorViews")){
  //   separatorView.hidden = YES;
  // }

  // layerBordersForAll(r);

  // NSArray* m_systemButtonDescriptions;
  // NSMutableArray* m_currentSystemButtons;
  // NSMutableArray* m_extraButtons;
  return r;
}

-(CGRect)controlFrame{
  NSLog(@"CONTROL FRAME %@", NSStringFromCGRect(%orig));
  return %orig;
}

-(void)shrinkButtonTextSize:(id)arg1  { %log; /*%orig;*/ }

// - (void)didAddSubview:(UIView *)subview{
//
//   if([subview isMemberOfClass:%c(UICalloutBarButton)]){
//     HBLogDebug(@"Sub %@", [subview description]);
//
//     if([self viewWithTag: 1020] != nil){
//       HBLogDebug(@"MOVINGO %@", [subview description]);
//       [subview removeFromSuperview];
//       [[self viewWithTag: 1020] addSubview: subview];
//       // subview.backgroundColor = UIColor.blueColor;
//       // subview.frame = CGRectMake(0, theSize.height*btnCount, theSize.width, 40);
//
//     }
//
//   }
//
//   %orig;
// }

// -(void)layoutSubviews{
//   %orig;
//   HBLogDebug(@"LO");
//   for(UIView* subview in self.subviews){
//     if([subview isMemberOfClass:%c(UICalloutBarButton)]){
//
//       HBLogDebug(@"MOVING %@", [subview description]);
//       subview.backgroundColor = UIColor.blueColor;
//       subview.frame = CGRectMake(0, theSize.height*btnCount, theSize.width, 40);
//       HBLogDebug(@"MOVING N %@", [subview description]);
//
//     }
//
//   }
// }

// -(void)updateAvailableButtons {
//   %log;
//
//   for(UIView* subview in self.subviews){
//     HBLogDebug(@"UPDATE BUTTONG BEFORE %@", [subview description]);
//   }
//
//   %orig;
//
//   for(UIView* subview in self.subviews){
//     HBLogDebug(@"UPDATE BUTTONG AFTER %@", [subview description]);
//   }
//
//   btnCount = 0;
//   for(UIView* sub in self.subviews){
//     if([sub isMemberOfClass:%c(UICalloutBarButton)]){
//
//
//       sub.frame = CGRectMake(0,-80+(40*btnCount), theSize.width, 40);
//       sub.layer.borderColor = UIColor.blueColor.CGColor;
//       sub.layer.borderWidth = 1;
//
//       for(UIView* sub2 in sub.subviews){
//         sub2.layer.borderColor = UIColor.redColor.CGColor;
//         sub2.layer.borderWidth = 2;
//         HBLogDebug(@"update button sub %i %@", btnCount, [sub2 description]);
//
//       }
//       btnCount += 1;
//       HBLogDebug(@"update button after %@", [sub description]);
//     }
//   }
// }


-(void)updateForCurrentPage {
  %log;

  for(UIView* subview in self.subviews){
    HBLogDebug(@"UPDATE CURRENT PAGE BEFORE %@", [subview description]);
  }

  for(UIView* sub in self.subviews){
    if([sub isMemberOfClass:%c(UICalloutBarBackground)]){
      // sub.hidden = YES;
      int c = 0;
      for(UIView* subview in sub.subviews){
        HBLogDebug(@"BACKGROUND VIEW DESC2 %@", [subview description]);
        // subview.hidden = c % 2 == 0 ? YES : NO;
        MSHookIvar<UIView *>(sub, "_separatorView").hidden = YES;
        MSHookIvar<UIView *>(sub, "_blurView").hidden = YES;
        UIView* tint = MSHookIvar<UIView *>(sub, "_tintView");
        tint.hidden = YES;
//         HBLogDebug(@"ST TINT2 %@", [tint description]);
//
//         layerBordersForAll(tint);
//         layerBordersForAllLayers(tint.layer);
//         for(CALayer* st in tint.layer.sublayers){
//           HBLogDebug(@"ST TING %@", [st description]);
//           // .hidden = YES;
// //
//         }

        c += 1;
      }

    }else if([sub isMemberOfClass:%c(UICalloutBarButton)]){
      // sub.userInteractionEnabled = NO;
      // sub.hidden = YES;
    }
  }

  int buttonCount = 0;
  removeAllSubviewsWithTagRecursive(self, 1022);

  for(UIView* sub in self.subviews){
    if([sub isMemberOfClass:%c(UICalloutBarButton)]){

      float thickness = 1.5;
      float insetPercent = 0.1;
      float SEP_WIDTH = sub.superview.frame.size.width;
      if(buttonCount > 0){
        UIView* sepView = [[UIView alloc] initWithFrame:CGRectMake(SEP_WIDTH * insetPercent, (CELL_HEIGHT*buttonCount)-(thickness/2), SEP_WIDTH - (SEP_WIDTH*insetPercent*2), thickness)];
        sepView.backgroundColor = UIColor.grayColor;
        sepView.tag = 1022;
        [viewWithTag(self, 1020) addSubview: sepView];
      }

      sub.frame = CGRectMake(0,CELL_HEIGHT*buttonCount, theSize.width, CELL_HEIGHT);
      // sub.layer.borderColor = UIColor.yellowColor.CGColor;
      // sub.layer.borderWidth = 1;

      for(UIView* sub2 in sub.subviews){
        // sub2.layer.borderColor = UIColor.greenColor.CGColor;
        // sub2.layer.borderWidth = 2;
        HBLogDebug(@"UPDATE CURRENT PAGE AFTER SUB DESC %i %@", buttonCount, [sub2 description]);

        if([sub2 isMemberOfClass:%c(UIButtonLabel)]){
          UIButtonLabel* labelView = (UIButtonLabel*)sub2;

          CGRect newLabelFrame = CGRectMake(0, 0, labelView.superview.frame.size.width, labelView.superview.frame.size.height);
          labelView.frame = newLabelFrame;
          labelView.numberOfLines = 2;
          HBLogDebug(@"LABEL TEXT %@ %@", labelView.text, NSStringFromCGRect(labelView.frame));
          // labelView.layer.borderColor = UIColor.yellowColor.CGColor;
          // labelView.layer.borderWidth = 2;
        }

        if([sub2 isMemberOfClass:%c(UIImageView)]){
          HBLogDebug(@"IMAGE VIEW FOUND");
        }

      }


      NSLog(@"43 BUTTON %lli %i %@", ((UICalloutBarButton*)sub).page, sub.hidden, [sub description]);
      // sub.hidden = NO;

      if(sub.hidden == NO){
        buttonCount += 1;
      }
      HBLogDebug(@"UPDATE CURRENT PAGE AFTER %@", [sub description]);

      if(sub.superview.tag != 1020){
        [sub removeFromSuperview];
        [viewWithTag(self, 1020) addSubview: sub];

      }
    }
  }
  // layerBordersForAll(self);
  ((UIScrollView*)viewWithTag(self, 1020)).contentSize = CGSizeMake(theSize.width, buttonCount*CELL_HEIGHT);


  // int buttonCount = 0;
  // for(UIView* sub in r.subviews){
  //   if([sub isMemberOfClass:%c(UICalloutBarButton)]){
  //     buttonCount += 1;
  //   }
  // }

  if(viewWithTag(self, 1020) != nil){
    theSize = CGSizeMake(SIZE_WIDTH, (buttonCount*CELL_HEIGHT) < MAX_DEFAULT_HEIGHT ? (buttonCount*CELL_HEIGHT) : MAX_DEFAULT_HEIGHT);
    NSLog(@"NEW SIZE %i %@", buttonCount, NSStringFromCGSize(theSize));

    ((UIScrollView*)viewWithTag(self, 1020)).frame = CGRectMake(0, 0, theSize.width, theSize.height);
    [self setFrameForSize: theSize];
  }
  %orig;

}

-(void)updateForCurrentHorizontalPage{

  for(UIView* subview in self.subviews){
    HBLogDebug(@"UPDATE HORZONTAL PAGE BEFORE %@", [subview description]);
  }

  %orig;

  for(UIView* subview in self.subviews){
    HBLogDebug(@"UPDATE HORZONTAL PAGE AFTER %@", [subview description]);
  }

}

-(void)updateForCurrentVerticalPage{

  for(UIView* subview in self.subviews){
    HBLogDebug(@"UPDATE VERT PAGE BEFORE %@", [subview description]);
  }

  %orig;

  for(UIView* subview in self.subviews){
    HBLogDebug(@"UPDATE VERt PAGE AFTER %@", [subview description]);
  }

}


- (void)addVerticalSeparatorAfterButton:(id)arg1{
  NSLog(@"Blocked vertical separator");
}
%end

static UIView* viewWithTag(UIView* superview, int tag){
  for(UIView *s in superview.subviews){
    if(s.tag == tag){
      return s;
    }
    viewWithTag(s, tag);
  }
  return nil;
}

static void removeAllSubviewsWithTagRecursive(UIView* superview, int tag){
  for(UIView *s in superview.subviews){
    if(s.tag == tag){
      [s removeFromSuperview];
    }
    removeAllSubviewsWithTagRecursive(s, tag);
  }
}

//
// static void layerBordersForAll(UIView* view){
//   for(UIView* sub in view.subviews){
//     sub.layer.borderColor = UIColor.cyanColor.CGColor;
//     sub.layer.borderWidth = 1;
//
//     layerBordersForAll(sub);
//   }
// }
//
//
// static void layerBordersForAllLayers(CALayer* layer){
//   for(CALayer* sub in layer.sublayers){
//     sub.borderColor = UIColor.cyanColor.CGColor;
//     sub.borderWidth = 1;
//
//     layerBordersForAllLayers(sub);
//   }
// }






%hook UICalloutBarButton
-(void)setPage:(long long)arg1{

  // self.page = 0;
  self.hidden = NO;
}

-(long long)page{
  return 0;
}
// -(void)setupWithTitle:(id)arg1 subtitle:(id)arg2 maxWidth:(double)arg3 action:(SEL)arg4 type:(int)arg5{
//   HBLogDebug(@"CALLBAR BUTTON SETUP 4");
//   %orig;
// }
//
// -(void)setupWithImage:(id)arg1 action:(SEL)arg2 type:(int)arg3{
//   %orig;
//   HBLogDebug(@"CALLBAR BUTTON SETUP 3 %@", [self description]);
// }
//
// -(void)setupWithTitle:(id)arg1 action:(SEL)arg2 type:(int)arg3{
//   HBLogDebug(@"CALLBAR BUTTON SETUP 2");
//   %orig;
// }
//
// -(void)_commonSetupWithAction:(SEL)arg1 type:(int)arg2{
//   %orig;
//   HBLogDebug(@"CALLBAR BUTTON SETUP 1 %@", [self description]);
// }
//
// -(CGRect)adjustRectForPosition:(CGRect)arg1 scaleRect:(bool)arg2{
//   CGRect o = %orig(CGRectMake(2,7.5,30, 21.5), arg2);
//   // {2, 7.5}, {14.5, 21.5}}
//   HBLogDebug(@"CALLBAR BUTTON RECT %@ %@", NSStringFromCGRect(arg1), NSStringFromCGRect(o));
//   return CGRectMake(0,50,70, 21.5);//o;
// }
//
-(double)contentWidth{
  double o = %orig;
  NSLog(@"WIDTH %f %f", o, theSize.width);
  return theSize.width;
}
//
// -(double)contentScale{
//   double o = %orig;
//   NSLog(@"SCALE %f", o);
//   return o;
// }
//
-(void)configureLabel{
  NSLog(@"LABEL %lu", (long)self.subviews.count);
  %orig;
  NSLog(@"LABEL %lu", (long)self.subviews.count);
  for(UIView* sub in self.subviews){
    HBLogDebug(@"LABEL DESC: %@", [sub description]);
    if([sub isMemberOfClass:%c(UIButtonLabel)]){
      sub.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    HBLogDebug(@"LABEL DESC2: %@", [sub description]);
  }
}
%end




/*

setFrameForSize:{250, 36}]
calculateControlFrameForCalloutSize:{250, 36} below:1]
supressHorizontalXMovementIfNeededForPoint:{162.5, 369} proposedX:37.000000
supressesHorizontalMovement 0
rectClear:{{37, 318}, {250, 36}}]
rectsToEvade
controlFrame = = {{37, 318}, {250, 36}}

textEffectsWindowSafeArea // screen size?

[<UICalloutBar: 0x105cc2610> shrinkButtonTextSize:<UICalloutBarButton: 0x105cd4d00; frame = (0 0; 78 36); opaque = NO; layer = <CALayer: 0x280243280>>]
[<UICalloutBar: 0x105cc2610> shrinkButtonTextSize:<UICalloutBarButton: 0x105cd5480; frame = (78 0; 99 36); opaque = NO; layer = <CALayer: 0x280243520>>]
[<UICalloutBar: 0x105cc2610> shrinkButtonTextSize:<UICalloutBarButton: 0x1099c4680; frame = (177 0; 73 36); opaque = NO; layer = <CALayer: 0x28025e7c0>>]
adjustFrameToAvoidDividerOnArrow

supressesHorizontalMovement 0

// press copy
buttonHighlighted:<UICalloutBarButton: 0x105cd3d20; frame = (0 0; 30 34); hidden = YES; opaque = NO; layer = <CALayer: 0x280243040>> highlighted:0]
_updateVisibleItemsAnimated
hasReplacements
setCurrentAppearOrFadeContext:{
clearReplacements

<UICalloutBar: 0x105cc2610; frame = (37 318; 250 45); tintColor = UIExtendedGrayColorSpace 1 1; gestureRecognizers = <NSArray: 0x280dd0180>; animations = { opacity=<CABasicAnimation: 0x280243dc0>; }; layer = <CALayer: 0x280241be0>>
controlFrame = {{37, 318}, {250, 36}}
targetPoint = {162.5, 369}
<UICalloutBar: 0x105cc2610; frame = (37 318; 250 45); tintColor = UIExtendedGrayColorSpace 1 1; gestureRecognizers = <NSArray: 0x280dd0180>; animations = { opacity=<CABasicAnimation: 0x280243dc0>; }; layer = <CALayer: 0x280241be0>>

currentAppearOrFadeContext
setCurrentAppearOrFadeContext:(null)]
-[<UICalloutBar: 0x105cc2610> hitTest:{53.5, 8} withEvent:<UITouchesEvent: 0x283176010> timestamp: 221572 touches: {(
[<UICalloutBar: 0x105cc2610> pointInside:{53.5, 18} withEvent:<UITouchesEvent: 0x283176010> timestamp: 221572 touches:
    = 1


<UICalloutBarButton: 0x105cd4d00; frame = (0 0; 78 36); opaque = NO; layer = <CALayer: 0x280243280>>
[<UICalloutBar: 0x105cc2610> hitTest:{53.5, 8} withEvent:<UITouchesEvent: 0x283176010> timestamp: 221572 touches:
[<UICalloutBar: 0x105cc2610> pointInside:{53.5, 18} withEvent:<UITouchesEvent: 0x283176010> timestamp: 221572 touches:
    = 1

     <UICalloutBarButton: 0x105cd4d00; frame = (0 0; 78 36); opaque = NO; layer = <CALayer: 0x280243280>>
      +[<UICalloutBar: 0x275cb4728> activeCalloutBar]
      = <UICalloutBar: 0x105cc2610; frame = (37 318; 250 45); tintColor = UIExtendedGrayColorSpace 1 1; gestureRecognizers = <NSArray: 0x280dd0180>; layer = <CALayer: 0x280241be0>>

      -[<UICalloutBar: 0x105cc2610> visible] = 1
      [<UICalloutBar: 0x105cc2610> _touchesInsideShouldHideCalloutBar] = 0
*/
// %hook UICalloutBarButton
// - (SEL)action { %log; SEL  r = %orig; HBLogDebug(@" = %@", NSStringFromSelector(r)); return r; }
// - (double)contentWidth { %log; double  r = %orig; HBLogDebug(@" = %f", r); return r; }
// - (double)contentScale { %log; double  r = %orig; HBLogDebug(@" = %f", r); return r; }
// - (double)additionalContentHeight { %log; double  r = %orig; HBLogDebug(@" = %f", r); return r; }
// - (int)type { %log; int  r = %orig; HBLogDebug(@" = %d", r); return r; }
// - (void)setForceFlash:(bool)forceFlash { %log; %orig; }
// - (bool)forceFlash { %log; bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
// - (void)setPage:(long long)page { %log; %orig; }
// - (long long)page { %log; long long  r = %orig; HBLogDebug(@" = 0x%x", (unsigned int)r); return r; }
// - (void)setDividerOffset:(double)dividerOffset { %log; %orig; }
// - (double)dividerOffset { %log; double  r = %orig; HBLogDebug(@" = %f", r); return r; }
// - (void)setImageVerticalAdjust:(double)imageVerticalAdjust { %log; %orig; }
// - (double)imageVerticalAdjust { %log; double  r = %orig; HBLogDebug(@" = %f", r); return r; }
// - (void)setDontDismiss:(bool)dontDismiss { %log; %orig; }
// - (bool)dontDismiss { %log; bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
// - (void)setTextReplacement:(UITextReplacement*)textReplacement { %log; %orig; }
// - (UITextReplacement*)textReplacement { %log; UITextReplacement*  r = %orig; HBLogDebug(@" = %@", r); return r; }
// +(id)buttonWithTitle:(id)arg1 subtitle:(id)arg2 maxWidth:(double)arg3 action:(SEL)arg4 type:(int)arg5 inView:(id)arg6  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
// +(id)buttonWithTitle:(id)arg1 action:(SEL)arg2 type:(int)arg3 inView:(id)arg4  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
// +(id)buttonWithImage:(id)arg1 action:(SEL)arg2 type:(int)arg3 inView:(id)arg4  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
// -(void)removeFromSuperview { %log; %orig; }
// -(void)layoutSubviews { %log; %orig; }
// -(void)dealloc { %log; %orig; }
// -(void)setHighlighted:(bool)arg1  { %log; %orig; }
// -(CGRect)titleRectForContentRect:(CGRect)arg1  { %log; CGRect r = %orig; HBLogDebug(@" = {{%g, %g}, {%g, %g}}", r.origin.x, r.origin.y, r.size.width, r.size.height); return r; }
// -(CGRect)imageRectForContentRect:(CGRect)arg1  { %log; CGRect r = %orig; HBLogDebug(@" = {{%g, %g}, {%g, %g}}", r.origin.x, r.origin.y, r.size.width, r.size.height); return r; }
// -(double)_scaleFactorForImage { %log; double r = %orig; HBLogDebug(@" = %f", r); return r; }
// -(void)setupWithTitle:(id)arg1 subtitle:(id)arg2 maxWidth:(double)arg3 action:(SEL)arg4 type:(int)arg5  { %log; %orig; }
// -(void)setupWithTitle:(id)arg1 action:(SEL)arg2 type:(int)arg3  { %log; %orig; }
// -(void)setupWithImage:(id)arg1 action:(SEL)arg2 type:(int)arg3  { %log; %orig; }
// -(void)flash { %log; %orig; }
// -(void)_commonSetupWithAction:(SEL)arg1 type:(int)arg2  { %log; %orig; }
// -(void)cancelFlash { %log; %orig; }
// -(void)configureLabel { %log; %orig; }
// -(CGRect)adjustRectForPosition:(CGRect)arg1 scaleRect:(bool)arg2  { %log; CGRect r = %orig; HBLogDebug(@" = {{%g, %g}, {%g, %g}}", r.origin.x, r.origin.y, r.size.width, r.size.height); return r; }
// -(void)fadeAndSendAction { %log; %orig; }
// -(void)configureForSingle:(int)arg1  { %log; %orig; }
// -(void)configureForLeftPosition:(int)arg1  { %log; %orig; }
// -(void)configureForMiddlePosition { %log; %orig; }
// -(void)configureForRightPosition:(int)arg1  { %log; %orig; }
// -(void)setContentScale:(double)arg1  { %log; %orig; }
// %end

%ctor {
  HBLogDebug(@"start2");
  %init();
}
