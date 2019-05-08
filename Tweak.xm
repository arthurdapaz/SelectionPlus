#import "headers.h"

NSMutableDictionary *prefs, *defaultPrefs;

// prefs values
static bool ENABLED = YES;
static int NUM_OPTIONS = 3;
static float CELL_HEIGHT = 40;
static float SEP_WIDTH = 80;
static float SIZE_HEIGHT = 0;
static float WINDOW_WIDTH = 40;

static float FONT_MULTIPLIER = 50;

static UIColor *BACKGROUND_COLOR;// = [UIColor colorWithRed:14.0f/255.0f green:14.0f/255.0f blue:14.0f/255.0f alpha:0.8f];
static UIColor *BORDER_COLOR;// = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
static UIColor *SEPARATOR_COLOR;// = [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1];

static int TEXT_ALIGNMENT = 2;

static float getFontMultiplier(){
  return FONT_MULTIPLIER/100.0f;
}

static UIColor* sepColor(){
  loadPrefs();
  return SEPARATOR_COLOR == nil ? LCPParseColorString(@"#808080", @"#808080") : SEPARATOR_COLOR;
}

static UIColor* borderColor(){
  loadPrefs();
  return BORDER_COLOR == nil ? LCPParseColorString(@"#ffffff", @"#ffffff") : BORDER_COLOR;
}

static UIColor* bgColor(){
  loadPrefs();
  return BACKGROUND_COLOR == nil ? LCPParseColorString(@"#0e0e0e:0.8f", @"#0e0e0e:0.8f") : BACKGROUND_COLOR;
}


CGPoint targetPoint;
int targetDirection;

static float getSizeWidth(){
  if([UIScreen mainScreen] != nil){
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float desiredWidth = screenWidth * (WINDOW_WIDTH/100.0f);
    // NSLog(@"TARGET %@ %i", NSStringFromCGPoint(targetPoint), targetDirection);
    // // none of this should run since we are forcing the arrow to never be this direction
    // if(targetDirection == 3){
    //   // arrow on right
    //   float maxWidth = (screenWidth - targetPoint.x) * 0.9;
    //
    //   if(desiredWidth > maxWidth){
    //     NSLog(@"MAXED %f %f", desiredWidth, maxWidth);
    //     return maxWidth;
    //   }
    // }
    //
    // if(targetDirection == 0){
    //   float maxWidth = (targetPoint.x) * 0.9;
    //
    //   if(desiredWidth > maxWidth){
    //     NSLog(@"MAXED %f %f", desiredWidth, maxWidth);
    //     return maxWidth;
    //   }
    // }

    float maxWidth = screenWidth * 0.95;
    if(desiredWidth > maxWidth){
      return maxWidth;
    }

    return desiredWidth;
  }
  return 0;
}




static float MAX_DEFAULT_HEIGHT(){

  if([UIScreen mainScreen] != nil){
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    float desiredHeight = NUM_OPTIONS * CELL_HEIGHT;
    // NSLog(@"TARGET2 %@ %i %f", NSStringFromCGPoint(targetPoint), targetDirection, screenHeight);

    // if(targetDirection == 1){
    //   // arrow on bottom
    //   float maxHeight = (screenHeight - targetPoint.y) * 0.9;
    //
    //   if(desiredHeight > maxHeight){
    //     NSLog(@"MAXEDH %f %f", desiredHeight, maxHeight);
    //     return maxHeight;
    //   }
    // }
    //
    // if(targetDirection == 2){
    //   float maxHeight = (targetPoint.y) * 0.9;
    //
    //   if(desiredHeight > maxHeight){
    //     NSLog(@"MAXEDH2 %f %f", desiredHeight, maxHeight);
    //     return maxHeight;
    //   }
    // }
    //
    float maxHeight = screenHeight * 0.25;
    if(desiredHeight > maxHeight){
      return maxHeight;
    }

    return desiredHeight;
  }
  return 120;
}

static float getSepInset(){
  return (1.0f - (SEP_WIDTH/100.0f))/2.0f;
}

static CGSize theSize(){
  return CGSizeMake(getSizeWidth(), SIZE_HEIGHT);
}

%hook UICalloutBar

-(id)hitTest:(CGPoint)arg1 withEvent:(id)arg2  {
  if(ENABLED){
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    if ([self pointInside:arg1 withEvent:arg2]) {
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subview convertPoint:arg1 fromView:self];
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:arg2];
            if (hitTestView) {
                if([hitTestView isMemberOfClass:%c(UICalloutBarButton)]){
                  [UIView animateWithDuration:0.2f delay:0 options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)  animations:^{
                      hitTestView.layer.backgroundColor = UIColor.whiteColor.CGColor;
                  } completion:^(BOOL finished) {
                      [UIView animateWithDuration:0.2f delay:0 options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)  animations:^{
                          hitTestView.layer.backgroundColor = UIColor.clearColor.CGColor;
                      } completion:nil];
                  }];
                }
                return hitTestView;
            }
        }
        return self;
    }
    return nil;
  }else{
    return %orig;
  }
}

-(bool)setFrameForSize:(CGSize)arg1  {
  if(ENABLED){
    return %orig(theSize());
  }else{
    return %orig;
  }
}

-(bool)calculateControlFrameForCalloutSize:(CGSize)arg1 below:(bool)arg2  {
  if(ENABLED){
    return %orig(theSize(), arg2);
  }else{
    return %orig;
  }
}

-(bool)calculateControlFrameForCalloutSize:(CGSize)arg1 right:(bool)arg2  {
  if(ENABLED){
    return %orig(theSize(), arg2);
  }else{
    return %orig;
  }
}

-(bool)calculateControlFrameInsideTargetRect:(CGSize)arg1{
  if(ENABLED){
    return %orig(theSize());
  }else{
    return %orig;
  }
}

-(void)setTargetHorizontal:(bool)arg1{
  %orig(0);
}

+(id)sharedCalloutBar {
  UICalloutBar* r = %orig;
  if(ENABLED){
    MSHookIvar<UIView *>(r, "m_nextButton").hidden = YES;
    MSHookIvar<UIView *>(r, "m_previousButton").hidden = YES;

    if(viewWithTag(r, 1020) == nil){
      CGSize windowSize = theSize();
      UIScrollView* sub = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowSize.width, windowSize.height)];
      sub.tag = 1020;
      sub.indicatorStyle = UIScrollViewIndicatorStyleWhite;
      r.clipsToBounds = true;
      sub.contentSize = CGSizeMake(windowSize.width, windowSize.height);

      sub.backgroundColor = bgColor();
      sub.layer.borderWidth = 2;
      sub.layer.borderColor = borderColor().CGColor;

      [r addSubview: sub];
    }

    return r;
  }else{
    return %orig;
  }
}

-(void)shrinkButtonTextSize:(id)arg1  {
  if(ENABLED == NO){
    %orig;
  }
}

-(int)targetDirection{
  int dir = %orig;
  targetDirection = dir;
  return dir;//targetPoint.y > ([UIScreen mainScreen].bounds.size.height - targetPoint.y) ? 2 : 1;
}

-(void)setTargetPoint:(CGPoint)arg1{
  targetPoint = arg1;
  %orig;
}
-(CGPoint)targetPoint{
  CGPoint point = %orig;
  targetPoint = point;
  return point;
}

-(void)updateForCurrentPage {
  if(ENABLED){
    for(UIView* sub in self.subviews){
      if([sub isMemberOfClass:%c(UICalloutBarBackground)]){
        MSHookIvar<UIView *>(sub, "_separatorView").hidden = YES;
        MSHookIvar<UIView *>(sub, "_blurView").hidden = YES;
        UIView* tint = MSHookIvar<UIView *>(sub, "_tintView");
        tint.hidden = YES;
      }
    }

    int buttonCount = 0;
    removeAllSubviewsWithTagRecursive(self, 1022);

    for(UIView* sub in self.subviews){
      if([sub isMemberOfClass:%c(UICalloutBarButton)]){

        float thickness = 1.5;
        float insetPercent = getSepInset();
        float SEP_WIDTH = sub.superview.frame.size.width;
        if(buttonCount > 0){
          UIView* sepView = [[UIView alloc] initWithFrame:CGRectMake(SEP_WIDTH * insetPercent, (CELL_HEIGHT*buttonCount)-(thickness/2), SEP_WIDTH - (SEP_WIDTH*insetPercent*2), thickness)];
          sepView.backgroundColor = sepColor();
          sepView.tag = 1022;
          [viewWithTag(self, 1020) addSubview: sepView];
        }

        sub.frame = CGRectMake(0,CELL_HEIGHT*buttonCount, theSize().width, CELL_HEIGHT);

        for(UIView* sub2 in sub.subviews){

          if([sub2 isMemberOfClass:%c(UIButtonLabel)]){
            UIButtonLabel* labelView = (UIButtonLabel*)sub2;

            CGRect newLabelFrame = CGRectMake(0, 0, labelView.superview.frame.size.width, labelView.superview.frame.size.height);
            labelView.frame = newLabelFrame;
            labelView.numberOfLines = 2;
          }
        }

        if(sub.hidden == NO){
          buttonCount += 1;
        }

        if(sub.superview.tag != 1020){
          [sub removeFromSuperview];
          [viewWithTag(self, 1020) addSubview: sub];
        }
      }
    }

    ((UIScrollView*)viewWithTag(self, 1020)).contentSize = CGSizeMake(theSize().width, buttonCount*CELL_HEIGHT);
    [((UIScrollView*)viewWithTag(self, 1020)) flashScrollIndicators];

    if(viewWithTag(self, 1020) != nil){
      float max = MAX_DEFAULT_HEIGHT();
      SIZE_HEIGHT = (buttonCount*CELL_HEIGHT) < max ? (buttonCount*CELL_HEIGHT) : max;

      CGSize winSize = theSize();
      ((UIScrollView*)viewWithTag(self, 1020)).frame = CGRectMake(0, 0, winSize.width, winSize.height);
      ((UIScrollView*)viewWithTag(self, 1020)).layer.cornerRadius = winSize.width*0.05;
      [self setFrameForSize: winSize];
    }
    %orig;

  }else{
    %orig;
  }
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

%hook UICalloutBarButton
-(void)setPage:(long long)arg1{
  if(ENABLED){
    self.hidden = NO;
  }else{
    %orig;
  }
}

-(long long)page{
  if(ENABLED){
    return 0;
  }else{
    return %orig;
  }
}

-(void)fadeAndSendAction{
  %orig;

  // [UIView animateWithDuration:0.25f delay:0 options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)  animations:^{
  //     self.layer.backgroundColor = UIColor.whiteColor.CGColor;
  // } completion:^(BOOL finished) {
  //     [UIView animateWithDuration:0.25f delay:0 options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)  animations:^{
  //         self.layer.backgroundColor = UIColor.clearColor.CGColor;
  //     } completion:nil];
  // }];
}

-(void)layoutSubviews{
  if(ENABLED){
    %orig;

    for(UIView* sub in self.subviews){
      if([sub isMemberOfClass:%c(UIButtonLabel)]){
        float widthInsetPercent = 0.02;
        float width = self.frame.size.width;
        sub.frame = CGRectMake(width*widthInsetPercent, 0, width*(1.0f-(widthInsetPercent*2)), self.frame.size.height);
        ((UILabel*)sub).adjustsFontSizeToFitWidth = YES;
        sub.backgroundColor = UIColor.clearColor;
        ((UILabel*)sub).textAlignment = TEXT_ALIGNMENT == 1 ? NSTextAlignmentLeft : TEXT_ALIGNMENT == 2 ? NSTextAlignmentCenter : TEXT_ALIGNMENT == 3 ? NSTextAlignmentRight : NSTextAlignmentCenter; // default center
        ((UILabel*)sub).font = findAdaptiveFontWithName(((UILabel*)sub).font.fontName/*@"HelveticaNeue-Light"*/, sub.frame.size, 1, getFontMultiplier());
      }else if([sub isMemberOfClass:%c(UIImageView)]){
        float fontMult = getFontMultiplier();
        float width = self.frame.size.width;
        float height = self.frame.size.height*fontMult;
        sub.frame = CGRectMake(0, height/2, width, height);
        ((UIImageView*)sub).contentMode = UIViewContentModeScaleAspectFit;
      }
    }
  }else{
    %orig;
  }
}
%end

//https://stackoverflow.com/questions/8812192/how-to-set-font-size-to-fill-uilabel-height/17622215#17622215
static UIFont* findAdaptiveFontWithName(NSString *fontName, CGSize labelSize, NSInteger minSize, float multiplier)
{
    UIFont *tempFont = nil;
    NSString *testString = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

    NSInteger tempMin = minSize;
    NSInteger tempMax = 256;
    NSInteger mid = 0;
    NSInteger difference = 0;

    while (tempMin <= tempMax) {
        mid = tempMin + (tempMax - tempMin) / 2;
        tempFont = [UIFont fontWithName:fontName size:mid];
        difference = labelSize.height - [testString sizeWithFont:tempFont].height;

        if (mid == tempMin || mid == tempMax) {
            if (difference < 0) {
                return [UIFont fontWithName:fontName size:(mid - 1)];
            }

            return [UIFont fontWithName:fontName size:mid*multiplier];
        }

        if (difference < 0) {
            tempMax = mid - 1;
        } else if (difference > 0) {
            tempMin = mid + 1;
        } else {
            return [UIFont fontWithName:fontName size:mid*multiplier];
        }
    }

    return [UIFont fontWithName:fontName size:mid*multiplier];
}

static void initPrefs() {
	// Copy the default preferences file when the actual preference file doesn't exist
	NSString *path = @"/var/mobile/Library/Preferences/com.satvikb.selectionplusprefs.plist";
	NSString *pathDefault = @"/Library/PreferenceBundles/SelectionPlusPrefs.bundle/defaults.plist";
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:path]) {
		[fileManager copyItemAtPath:pathDefault toPath:path error:nil];
	}

	defaultPrefs = [[NSMutableDictionary alloc] initWithContentsOfFile:pathDefault];
}


static void loadPrefs()
{
    prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.satvikb.selectionplusprefs.plist"];
    if(prefs){
        ENABLED = ( [prefs objectForKey:@"EnabledSwitch"] ? [[prefs objectForKey:@"EnabledSwitch"] boolValue] : ENABLED );
        NUM_OPTIONS = ( [prefs objectForKey:@"NumOptions"] ? [[prefs objectForKey:@"NumOptions"] intValue] : NUM_OPTIONS );
        CELL_HEIGHT = ( [prefs objectForKey:@"CellHeight"] ? [[prefs objectForKey:@"CellHeight"] floatValue] : CELL_HEIGHT );
        SEP_WIDTH = ( [prefs objectForKey:@"SepWidth"] ? [[prefs objectForKey:@"SepWidth"] floatValue] : SEP_WIDTH );
        WINDOW_WIDTH = ( [prefs objectForKey:@"WindowWidth"] ? [[prefs objectForKey:@"WindowWidth"] floatValue] : WINDOW_WIDTH );
        FONT_MULTIPLIER = ( [prefs objectForKey:@"FontMultiplier"] ? [[prefs objectForKey:@"FontMultiplier"] floatValue] : FONT_MULTIPLIER );

        TEXT_ALIGNMENT = ( [prefs objectForKey:@"TextAlignment"] ? [[prefs objectForKey:@"TextAlignment"] intValue] : TEXT_ALIGNMENT );

        BACKGROUND_COLOR = LCPParseColorString([prefs objectForKey:@"BackgroundColor"], @"#0e0e0e:0.8f");
        BORDER_COLOR = LCPParseColorString([prefs objectForKey:@"BorderColor"], @"#808080");
        SEPARATOR_COLOR = LCPParseColorString([prefs objectForKey:@"SeparatorColor"], @"#ffffff");
        // NSLog(@"Load bg color %@", BACKGROUND_COLOR);
    }
}

%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.satvikb.selectionplusprefs/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
  initPrefs();
  loadPrefs();
  %init();
}
