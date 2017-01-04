
#import <Foundation/Foundation.h>

@interface NPDigits : NSObject
@property (nonatomic, readonly) NSString *stringValue;
@property (nonatomic, readonly) NSDecimalNumber *decimalNumber;
@property (nonatomic, readonly) NSString *decimalSeparator;
- (void)addDigit:(int)digit;
- (void)addDecimalSeparator;
- (void)clear;
@end
