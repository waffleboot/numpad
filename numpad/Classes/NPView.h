
#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface NPView : UIView
@property (nonatomic) NSDecimalNumber *amount;
@property (nonatomic) IBInspectable CGFloat fontSize;
- (void)clear;
@end
