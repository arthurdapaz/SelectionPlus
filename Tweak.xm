#import "headers.h"

// prefs values
static bool ENABLED = YES;
static int NUM_OPTIONS = 3;
// static float SIZE_WIDTH = 160;
static float CELL_HEIGHT = 40;
// static CGSize theSize() = CGSizeMake(160, 0);
static float SEP_WIDTH = 80;
static float SIZE_HEIGHT = 0;
static float WINDOW_WIDTH = 40;

static float getSizeWidth(){
  return [UIScreen mainScreen].bounds.size.width * (WINDOW_WIDTH/100.0f);
}

static CGSize theSize(){
  return CGSizeMake(getSizeWidth(), SIZE_HEIGHT);
}

static float getSepInset(){
  return (1.0f - (SEP_WIDTH/100.0f))/2.0f;
}

static float MAX_DEFAULT_HEIGHT(){
  return NUM_OPTIONS * CELL_HEIGHT;
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

+(id)sharedCalloutBar {
  UICalloutBar* r = %orig;
  if(ENABLED){
    MSHookIvar<UIView *>(r, "m_nextButton").hidden = YES;
    MSHookIvar<UIView *>(r, "m_previousButton").hidden = YES;

    if(viewWithTag(r, 1020) == nil){
      NSLog(@"SIZE 2222 %@", NSStringFromCGSize(theSize()));
      UIScrollView* sub = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, theSize().width, theSize().height)];
      sub.tag = 1020;
      sub.indicatorStyle = UIScrollViewIndicatorStyleWhite;
      r.clipsToBounds = true;
      sub.contentSize = CGSizeMake(theSize().width, theSize().height);

      sub.backgroundColor = [UIColor colorWithRed:14.0/255.0 green:14.0/255.0 blue:14.0/255.0 alpha:0.8];
      sub.layer.cornerRadius = theSize().width*0.05;
      sub.layer.borderWidth = 2;
      sub.layer.borderColor = UIColor.whiteColor.CGColor;

      [r addSubview: sub];
    }

    return r;
  }else{
    // if(viewWithTag(r, 1020) != nil){
    //   MSHookIvar<UIView *>(r, "m_nextButton").hidden = NO;
    //   MSHookIvar<UIView *>(r, "m_previousButton").hidden = NO;
    //   [[r viewWithTag: 1020] removeFromSuperview];
    // }
    return %orig;
  }
}

-(void)shrinkButtonTextSize:(id)arg1  {
  if(ENABLED == NO){
    %orig;
  }
}

-(void)updateForCurrentPage {
  if(ENABLED){

    for(UIView* sub in self.subviews){
      if([sub isMemberOfClass:%c(UICalloutBarBackground)]){
        // sub.hidden = YES;

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
          sepView.backgroundColor = UIColor.grayColor;
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

          // if([sub2 isMemberOfClass:%c(UIImageView)]){
          //   HBLogDebug(@"IMAGE VIEW FOUND");
          // }

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

    if(viewWithTag(self, 1020) != nil){
      SIZE_HEIGHT = (buttonCount*CELL_HEIGHT) < MAX_DEFAULT_HEIGHT() ? (buttonCount*CELL_HEIGHT) : MAX_DEFAULT_HEIGHT();

      ((UIScrollView*)viewWithTag(self, 1020)).frame = CGRectMake(0, 0, theSize().width, theSize().height);
      [self setFrameForSize: theSize()];
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

-(double)contentWidth{
  if(ENABLED){
    return theSize().width;
  }else{
    return %orig;
  }
}

-(void)configureLabel{
  if(ENABLED){
    %orig;
    for(UIView* sub in self.subviews){
      if([sub isMemberOfClass:%c(UIButtonLabel)]){
        sub.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
      }
    }
  }else{
    %orig;
  }
}
%end

static void loadPrefs()
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.satvikb.selectionplusprefs.plist"];
    if(prefs){
        ENABLED = ( [prefs objectForKey:@"EnabledSwitch"] ? [[prefs objectForKey:@"EnabledSwitch"] boolValue] : ENABLED );
        NUM_OPTIONS = ( [prefs objectForKey:@"NumOptions"] ? [[prefs objectForKey:@"NumOptions"] intValue] : NUM_OPTIONS );
        CELL_HEIGHT = ( [prefs objectForKey:@"CellHeight"] ? [[prefs objectForKey:@"CellHeight"] floatValue] : CELL_HEIGHT );
        SEP_WIDTH = ( [prefs objectForKey:@"SepWidth"] ? [[prefs objectForKey:@"SepWidth"] floatValue] : SEP_WIDTH );
        WINDOW_WIDTH = ( [prefs objectForKey:@"WindowWidth"] ? [[prefs objectForKey:@"WindowWidth"] floatValue] : WINDOW_WIDTH );
        theSize() = CGSizeMake(getSizeWidth(), theSize().height);
        NSLog(@"SIZE %@", NSStringFromCGSize(theSize()));
    }
}

%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.satvikb.selectionplusprefs/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
  loadPrefs();
  %init();
}
