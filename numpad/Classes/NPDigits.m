
#import "NPDigits.h"

typedef enum { kEmpty, kInteger, kDecimal } NPDigitsState;

@interface NPDigits ()
@property (nonatomic) NSString *stringValue;
@property (nonatomic) NSDecimalNumber *decimalNumber;
@property (nonatomic) NSString *decimalSeparator;
@end

@implementation NPDigits {
@private
  NSMutableString *_digits;
  NSNumberFormatter *_formatter;
  NPDigitsState _state;
}

- (instancetype)init {
  if (self = [super init]) {
    _state = kEmpty;
    _digits = [NSMutableString stringWithCapacity:8];
    self.decimalSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    _formatter = [NSNumberFormatter new];
    _formatter.numberStyle = NSNumberFormatterDecimalStyle;
    _formatter.groupingSize = 3;
  }
  return self;
}

- (void)addDigit:(int)digit {
  if (_state == kEmpty && digit == 0) { return; }
  [_digits appendFormat:@"%u", digit];
  switch (_state) {
    case kEmpty:
    case kInteger: {
      _state = kInteger;
      self.decimalNumber = [_formatter numberFromString:_digits];
      self.stringValue   = [_formatter stringFromNumber:self.decimalNumber];
      return;
    }
    case kDecimal: {
      _formatter.minimumFractionDigits++;
      _formatter.maximumFractionDigits++;
      self.stringValue = [self.stringValue stringByAppendingFormat:@"%u", digit];
      if (digit != 0) {
        self.decimalNumber = [_formatter numberFromString:_digits];
        return;
      }
    }
  }
}

- (void)addDecimalSeparator {
  switch (_state) {
    case kEmpty: {
      _state = kDecimal;
      [_digits appendFormat:@"0%@", self.decimalSeparator];
      self.stringValue = [NSString stringWithFormat:@"0%@", self.decimalSeparator];
      return;
    }
    case kInteger: {
      _state = kDecimal;
      [_digits appendFormat:@"%@", self.decimalSeparator];
      self.stringValue = [self.stringValue stringByAppendingFormat:@"%@", self.decimalSeparator];
      return;
    }
    case kDecimal: {
      [_digits appendString:@"0"];
      self.stringValue = [self.stringValue stringByAppendingString:@"0"];
      _formatter.minimumFractionDigits++;
      _formatter.maximumFractionDigits++;
      return;
    }
  }
}

- (void)clear {
  _state = kEmpty;
  self.stringValue = nil;
  self.decimalNumber = nil;
  [_digits setString:@""];
  _formatter.maximumFractionDigits = 0;
  _formatter.maximumFractionDigits = 0;
}

@end
