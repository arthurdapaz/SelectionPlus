#import <UIKit/UIKit.h>
// #include <execinfo.h>
#import <libcolorpicker.h>

// @interface UIMenuController : UIView
// @end



#import "UICalloutBarButton.h"
// static void layerBordersForAll(UIView* view);
// static void layerBordersForAllLayers(CALayer* layer);
static void removeAllSubviewsWithTagRecursive(UIView* superview, int tag);
static UIView* viewWithTag(UIView* superview, int tag);
// static NSMutableArray<UIView*>* viewsWithTag(UIView* superview, int tag);

static void loadPrefs();
static void initPrefs();

static float MAX_DEFAULT_HEIGHT();
static UIColor* sepColor();
static UIColor* borderColor();
static UIColor* bgColor();

static UIFont* findAdaptiveFontWithName(NSString *fontName, CGSize labelSize, NSInteger minSize, float multiplier);

@interface UIButtonLabel : UILabel
@end

@interface UICalloutBar : UIView{
  NSArray* m_systemButtonDescriptions;
  NSMutableArray* m_currentSystemButtons;
  NSMutableArray* m_extraButtons;
}

@property (assign,nonatomic) CGPoint pointAboveControls;
@property (assign,nonatomic) CGPoint pointBelowControls;
@property (assign,nonatomic) CGPoint pointLeftOfControls;
@property (assign,nonatomic) CGPoint pointRightOfControls;

-(CGPoint)targetPoint;


/*
  0 - arrow on left
  1 - arrow on bottom
  2 - arrow on top
  3 - arrow on right
*/
-(int)targetDirection;



-(void)updateAnimated:(bool)arg1;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

-(id)initWithFrame:(CGRect)arg1;
-(bool)setFrameForSize:(CGSize)arg1;
+(void)fadeSharedCalloutBar;
+(void)hideSharedCalloutBar;
+(id)sharedCalloutBar;

-(bool)recentlyFaded;

- (void)buttonHighlighted:(id)arg1 highlighted:(bool)arg2;
- (void)didAddSubview:(UIView *)subview;
-(bool)isDisplayingVertically;
// -(bool)setFrameForSize:(CGSize)arg1;
- (void)addVerticalSeparatorAfterButton:(id)arg1;
-(void)layoutSubviews;

@end

@interface UICalloutBar (SelectionPlus)
-(float)getSizeWidth;

// -(void)updateColor;
//
@end


@interface UICalloutBarBackground : UIView {
	bool m_isDisplayingVertically;
	UIVisualEffectView* _separatorView;
}
@end

// @interface UIMenuController : NSObject
// -(BOOL)isMenuVisible;
// -(void)setMenuVisible:(BOOL)arg1 animated:(BOOL)arg2 ;
// -(void)setMenuVisible:(BOOL)arg1 ;
// @end
