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
// @interface UICalloutBarButton : UIButton
// -(void)setPage:(long long)arg1;
// -(long long)page;
//
// -(void)setupWithTitle:(id)arg1 subtitle:(id)arg2 maxWidth:(double)arg3 action:(SEL)arg4 type:(int)arg5 ;
// -(void)setupWithTitle:(id)arg1 action:(SEL)arg2 type:(int)arg3 ;
// -(void)setupWithImage:(id)arg1 action:(SEL)arg2 type:(int)arg3 ;
// -(void)_commonSetupWithAction:(SEL)arg1 type:(int)arg2 ;
// -(CGRect)adjustRectForPosition:(CGRect)arg1 scaleRect:(bool)arg2;
// -(void)configureLabel;
// -(double)contentWidth;
// -(double)contentScale;
// @end


static float MAX_DEFAULT_HEIGHT();
static UIColor* sepColor();
static UIColor* borderColor();
static UIColor* bgColor();

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

-(id)initWithFrame:(CGRect)arg1;
-(bool)setFrameForSize:(CGSize)arg1;
+(void)fadeSharedCalloutBar;
+(id)sharedCalloutBar;

- (void)buttonHighlighted:(id)arg1 highlighted:(bool)arg2;
- (void)didAddSubview:(UIView *)subview;
-(bool)isDisplayingVertically;
// -(bool)setFrameForSize:(CGSize)arg1;
- (void)addVerticalSeparatorAfterButton:(id)arg1;
-(void)layoutSubviews;

@end

static UIFont* findAdaptiveFontWithName(NSString *fontName, CGSize labelSize, NSInteger minSize, float multiplier);

@interface UICalloutBarBackground : UIView {
	bool m_isDisplayingVertically;
	UIVisualEffectView* _separatorView;
}
@end
