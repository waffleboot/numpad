
#import <UIKit/UIKit.h>

@class NPView;

@protocol NPViewDelegate
- (void)numpad:(NPView*)view amount:(NSDecimalNumber*)amount;
@end

IB_DESIGNABLE
@interface NPView : UIView
@property (nonatomic) id <NPViewDelegate> delegate;
@property (nonatomic, readonly) NSDecimalNumber *amount;
@property (nonatomic) IBInspectable CGFloat fontSize;
- (void)clear;
@end
