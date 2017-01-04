
#import <Foundation/Foundation.h>

@interface NPDigits : NSObject
@property (nonatomic, readonly) NSString *stringValue;
@property (nonatomic, readonly) NSDecimalNumber *decimalNumber;
- (void)addDigit:(int)digit;
- (void)addDecimalSeparator;
- (void)clear;
@end
