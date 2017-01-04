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
  XCTAssertEqualObjects(digits.stringValue, @"0.");
  XCTAssertNil(digits.decimalNumber);
  [digits addDigit:0];
  XCTAssertEqualObjects(digits.stringValue, @"0.0");
  XCTAssertNil(digits.decimalNumber);
  [digits addDigit:0];
  XCTAssertEqualObjects(digits.stringValue, @"0.00");
  XCTAssertNil(digits.decimalNumber);
  [digits addDecimalSeparator];
  XCTAssertEqualObjects(digits.stringValue, @"0.00");
  XCTAssertNil(digits.decimalNumber);
  [digits addDigit:0];
  XCTAssertEqualObjects(digits.stringValue, @"0.000");
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
  [digits addDigit:1];
  XCTAssertEqualObjects(digits.stringValue, @"0.01");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.01]);
  [digits addDigit:0];
  XCTAssertEqualObjects(digits.stringValue, @"0.010");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.01]);
  [digits addDecimalSeparator];
  XCTAssertEqualObjects(digits.stringValue, @"0.010");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.01]);
  [digits addDigit:0];
  XCTAssertEqualObjects(digits.stringValue, @"0.0100");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.01]);
  [digits addDigit:8];
  XCTAssertEqualObjects(digits.stringValue, @"0.01008");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:0.01008]);
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
  XCTAssertEqualObjects(digits.stringValue, @"8.010");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:8.01]);
  [digits addDigit:0];
  XCTAssertEqualObjects(digits.stringValue, @"8.0100");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:8.01]);
  [digits addDigit:8];
  XCTAssertEqualObjects(digits.stringValue, @"8.01008");
  XCTAssertEqualObjects(digits.decimalNumber, [NSDecimalNumber numberWithDouble:8.01008]);
}

- (void)testClear {
  [self testZeroDecimalDigits];
  [digits clear];
  [self testIntegerDecimalDigits];
}

@end

