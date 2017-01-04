
#import "NPDigits.h"

@interface NPDigits ()
@property (nonatomic) NSString *stringValue;
@property (nonatomic) NSDecimalNumber *decimalNumber;
@end

@implementation NPDigits {
@private
  NSMutableString *digits;
  NSString *decimalSeparator;
  NSNumberFormatter *formatter;
  int fractionDigits;
  BOOL hasPoint;
}

- (instancetype)init {
  if (self = [super init]) {
    digits = [NSMutableString stringWithCapacity:8];
    decimalSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.groupingSize = 3;
  }
  return self;
}

- (void)addDigit:(int)digit {
  if (digits.length == 0 && digit == 0) { return; }
  if (hasPoint) { fractionDigits++; }
  [digits appendFormat:@"%u", digit];
  if (digit != 0 || self.decimalNumber != nil) {
    [self updateDecimalNumber];
  } else {
    self.stringValue = digits;
  }
}

- (void)addDecimalSeparator {
  if (digits.length == 0) {
    NSString *string = [NSString stringWithFormat:@"0%@", decimalSeparator];
    [digits setString:string];
    self.stringValue = string;
  } else if (!hasPoint) {
    [digits appendString:decimalSeparator];
    self.stringValue = [self.stringValue stringByAppendingString:decimalSeparator];
  }
  hasPoint = YES;
}

- (void)updateDecimalNumber {
  if (digits.length == 0) {
    self.stringValue = nil;
    self.decimalNumber = nil;
  } else {
    formatter.minimumFractionDigits = fractionDigits;
    formatter.maximumFractionDigits = fractionDigits;
    self.decimalNumber = (NSDecimalNumber*)[formatter numberFromString:digits];
    self.stringValue = [formatter stringFromNumber:self.decimalNumber];
  }
}

- (void)clear {
  hasPoint = NO;
  fractionDigits = 0;
  [digits setString:@""];
  [self updateDecimalNumber];
}

@end
