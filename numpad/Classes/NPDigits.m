
#import "NPDigits.h"

@interface NPDigits ()
@property (nonatomic) NSString *stringValue;
@property (nonatomic) NSDecimalNumber *decimalNumber;
@property (nonatomic) NSString *decimalSeparator;
@end

@implementation NPDigits {
@private
  NSMutableString *_digits;
  NSNumberFormatter *_formatter;
  int _fractionDigits;
  BOOL _hasPoint;
}

- (instancetype)init {
  if (self = [super init]) {
    _digits = [NSMutableString stringWithCapacity:8];
    self.decimalSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    _formatter = [NSNumberFormatter new];
    _formatter.numberStyle = NSNumberFormatterDecimalStyle;
    _formatter.groupingSize = 3;
  }
  return self;
}

- (void)addDigit:(int)digit {
  if (_digits.length == 0 && digit == 0) { return; }
  if (_hasPoint) { _fractionDigits++; }
  [_digits appendFormat:@"%u", digit];
  if (digit != 0 || self.decimalNumber != nil) {
    [self updateDecimalNumber];
  } else {
    self.stringValue = _digits;
  }
}

- (void)addDecimalSeparator {
  if (_digits.length == 0) {
    NSString *string = [NSString stringWithFormat:@"0%@", self.decimalSeparator];
    [_digits setString:string];
    self.stringValue = string;
  } else if (!_hasPoint) {
    [_digits appendString:self.decimalSeparator];
    self.stringValue = [self.stringValue stringByAppendingString:self.decimalSeparator];
  }
  _hasPoint = YES;
}

- (void)updateDecimalNumber {
  if (_digits.length == 0) {
    self.stringValue = nil;
    self.decimalNumber = nil;
  } else {
    _formatter.minimumFractionDigits = _fractionDigits;
    _formatter.maximumFractionDigits = _fractionDigits;
    self.decimalNumber = (NSDecimalNumber*)[_formatter numberFromString:_digits];
    self.stringValue = [_formatter stringFromNumber:self.decimalNumber];
    NSLog(@"%@", self.decimalNumber);
  }
}

- (void)clear {
  _hasPoint = NO;
  _fractionDigits = 0;
  [_digits setString:@""];
  [self updateDecimalNumber];
}

@end
