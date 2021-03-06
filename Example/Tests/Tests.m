//
//  numpadTests.m
//  numpadTests
//
//  Created by Andrei Yangabishev on 01/04/2017.
//  Copyright (c) 2017 Andrei Yangabishev. All rights reserved.
//

@import XCTest;

#import "NPDigits.h"

@interface Tests : XCTestCase

@end

@implementation Tests {
  NPDigits *digits;
}

- (void)setUp {
  [super setUp];
  digits = [NPDigits new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitialDigits {
  XCTAssertNil(digits.stringValue);
  XCTAssertNil(digits.decimalNumber);
}

- (void)testZeroDigits {
  
  [digits addDigit:0];

  XCTAssertNil(digits.stringValue);
  XCTAssertNil(digits.decimalNumber);

  [digits addDigit:0];
  
  XCTAssertNil(digits.stringValue);
  XCTAssertNil(digits.decimalNumber);
  
  [digits addDecimalSeparator];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.");
  XCTAssertNil(digits.decimalNumber);
  
  [digits addDecimalSeparator];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.0");
  XCTAssertNil(digits.decimalNumber);
  
  [digits addDigit:0];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.00");
  XCTAssertNil(digits.decimalNumber);
  
  [digits addDigit:0];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.000");
  XCTAssertNil(digits.decimalNumber);
  
  [digits addDecimalSeparator];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.0000");
  XCTAssertNil(digits.decimalNumber);
  
  [digits addDigit:0];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.00000");
  XCTAssertNil(digits.decimalNumber);
}

- (void)testIntegerDigits {
  [digits addDigit:0];
  XCTAssertNil(digits.stringValue);
  XCTAssertNil(digits.decimalNumber);
  [digits addDigit:1];
  XCTAssertEqualObjects(digits.stringValue, @"1");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithInt:1]);
  [digits addDigit:0];
  XCTAssertEqualObjects(digits.stringValue, @"10");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithInt:10]);
  [digits addDigit:2];
  XCTAssertEqualObjects(digits.stringValue, @"102");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithInt:102]);
}

- (void)testZeroDecimalDigits {

  [digits addDigit:0];
  
  XCTAssertNil(digits.stringValue);
  XCTAssertNil(digits.decimalNumber);
  
  [digits addDecimalSeparator];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.");
  XCTAssertNil(digits.decimalNumber);
  
  [digits addDigit:0];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.0");
  XCTAssertNil(digits.decimalNumber);
  
  [digits addDigit:2];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.02");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.02]);
  
  [digits addDigit:0];

  XCTAssertEqualObjects(digits.stringValue, @"0.020");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.02]);
  
  [digits addDecimalSeparator];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.0200");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.02]);
  
  [digits addDigit:0];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.02000");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.02]);
  
  [digits addDigit:0];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.020000");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.02]);
  
  [digits addDigit:8];
  
  XCTAssertEqualObjects(digits.stringValue, @"0.0200008");
  XCTAssertEqualWithAccuracy([digits.decimalNumber doubleValue], 0.0200008, 0.0000001);
  
  [digits clear];
  [digits addDecimalSeparator];
  [digits addDigit:1];
  XCTAssertEqualObjects(digits.stringValue, @"0.1");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.1]);
  [digits addDigit:2];
  XCTAssertEqualObjects(digits.stringValue, @"0.12");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.12]);
  [digits addDecimalSeparator];
  XCTAssertEqualObjects(digits.stringValue, @"0.120");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.12]);
}

- (void)testIntegerDecimalDigits {
  [digits addDigit:8];
  XCTAssertEqualObjects(digits.stringValue, @"8");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithInt:8]);
  [digits addDecimalSeparator];
  XCTAssertEqualObjects(digits.stringValue, @"8.");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithInt:8]);
  [digits addDigit:0];
  XCTAssertEqualObjects(digits.stringValue, @"8.0");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithInt:8]);
  [digits addDigit:1];
  XCTAssertEqualObjects(digits.stringValue, @"8.01");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:8.01]);
  [digits addDigit:0];
  XCTAssertEqualObjects(digits.stringValue, @"8.010");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:8.01]);
  [digits addDecimalSeparator];
  XCTAssertEqualObjects(digits.stringValue, @"8.0100");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:8.01]);
  [digits addDigit:0];
  XCTAssertEqualObjects(digits.stringValue, @"8.01000");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:8.01]);
  [digits addDigit:8];
  XCTAssertEqualObjects(digits.stringValue, @"8.010008");
  XCTAssertEqualWithAccuracy([digits.decimalNumber doubleValue], 8.010008, 0.00001);
}

- (void)testClear {
  [self testZeroDecimalDigits];
  [digits clear];
  [self testIntegerDecimalDigits];
}

- (void)testDecimalNumber {
  NSString *num = @"800,000,000.8650589";
  NSNumberFormatter *formatter = [NSNumberFormatter new];
  formatter.numberStyle = NSNumberFormatterDecimalStyle;
  formatter.minimumFractionDigits = 7;
  formatter.maximumFractionDigits = 7;
  NSDecimalNumber *decimalNumber = (NSDecimalNumber*)[formatter numberFromString:num];
  NSLog(@"%@", decimalNumber);
  NSLog(@"%@", [formatter stringFromNumber:decimalNumber]);
  // 800,000,000.8650589
  // 800,000,000.8650590
}

- (void)bugTestLongNumber {
  [digits addDigit:8];
  for (int i = 0; i < 8; ++i) {
    [digits addDigit:0];
  }
  [digits addDecimalSeparator];
  [digits addDigit:8];
  [digits addDigit:6];
  [digits addDigit:5];
  [digits addDigit:0];
  [digits addDigit:5];
  [digits addDigit:8];
  XCTAssertEqualObjects(digits.stringValue, @"800,000,000.865058");
  [digits addDigit:9];
  XCTAssertEqualObjects(digits.stringValue, @"800,000,000.8650589");
  [digits addDigit:0];
  [digits addDigit:5];
  [digits addDigit:5];
  XCTAssertEqualObjects(digits.stringValue, @"800,000,000.8650589055");
}

- (void)testSomeDecimalSeparators {
  [digits addDecimalSeparator];
  XCTAssertEqualObjects(digits.stringValue, @"0.");
  [digits addDecimalSeparator];
  XCTAssertEqualObjects(digits.stringValue, @"0.0");
  [digits addDecimalSeparator];
  XCTAssertEqualObjects(digits.stringValue, @"0.00");
  XCTAssertNil(digits.decimalNumber);
}

@end

