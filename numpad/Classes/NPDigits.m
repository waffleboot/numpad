
#import "NPDigits.h"

typedef enum { kEmpty, kInteger, kDecimal, kDecimalZero, kDecimalNotZero } NPDigitsState;

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
  switch (_state) {
    case kEmpty: {
      switch (digit) {
        case 0: {
          return;
        }
        default: {
          _state = kInteger;
          [_digits appendFormat:@"%u", digit];
          self.stringValue   = [NSString stringWithFormat:@"%u", digit];
          self.decimalNumber = [NSDecimalNumber numberWithInt:digit];
          return;
        }
      }
    }
    case kInteger: {
      _state = kInteger;
      [_digits appendFormat:@"%u", digit];
      self.decimalNumber = [_formatter numberFromString:_digits];
      self.stringValue   = [_formatter stringFromNumber:self.decimalNumber];
      return;
    }
    case kDecimal: {
      switch (digit) {
        case 0: {
          _state = kDecimalZero;
          [_digits appendString:@"0"];
          self.stringValue = [self.stringValue stringByAppendingString:@"0"];
          _formatter.minimumFractionDigits++;
          _formatter.maximumFractionDigits++;
          return;
        }
        default: {
          _state = kDecimalNotZero;
          [_digits appendFormat:@"%u", digit];
          _formatter.minimumFractionDigits++;
          _formatter.maximumFractionDigits++;
          self.decimalNumber = [_formatter numberFromString:_digits];
          self.stringValue   = [_formatter stringFromNumber:self.decimalNumber];
          return;
        }
      }
    }
    case kDecimalZero: {
      switch (digit) {
        case 0: {
          _state = kDecimalZero;
          [_digits appendString:@"0"];
          self.stringValue = [self.stringValue stringByAppendingString:@"0"];
          _formatter.minimumFractionDigits++;
          _formatter.maximumFractionDigits++;
          return;
        }
        default: {
          _state = kDecimalNotZero;
          [_digits appendFormat:@"%u", digit];
          self.stringValue = [self.stringValue stringByAppendingFormat:@"%u", digit];
          _formatter.minimumFractionDigits++;
          _formatter.maximumFractionDigits++;
          self.decimalNumber = [_formatter numberFromString:_digits];
          return;
        }
      }
    }
    case kDecimalNotZero: {
      switch (digit) {
        case 0: {
          _state = kDecimalZero;
          [_digits appendString:@"0"];
          self.stringValue = [self.stringValue stringByAppendingString:@"0"];
          _formatter.minimumFractionDigits++;
          _formatter.maximumFractionDigits++;
          return;
        }
        default: {
          _state = kDecimalNotZero;
          [_digits appendFormat:@"%u", digit];
          _formatter.minimumFractionDigits++;
          _formatter.maximumFractionDigits++;
          self.decimalNumber = [_formatter numberFromString:_digits];
          self.stringValue   = [_formatter stringFromNumber:self.decimalNumber];
          return;
        }
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
      _state = kDecimalZero;
      [_digits appendString:@"0"];
      self.stringValue = [self.stringValue stringByAppendingString:@"0"];
      _formatter.minimumFractionDigits++;
      _formatter.maximumFractionDigits++;
      return;
    }
    case kDecimalZero: {
      _state = kDecimalZero;
      [_digits appendString:@"0"];
      self.stringValue = [self.stringValue stringByAppendingString:@"0"];
      _formatter.minimumFractionDigits++;
      _formatter.maximumFractionDigits++;
      return;
    }
    case kDecimalNotZero: {
      _state = kDecimalZero;
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
