//
//  GGTabBarTests.m
//  Example
//
//  Created by Nicolas Goles on 6/8/14.
//  Copyright (c) 2014 Goles. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GGTabBar.h"
#import "GGTabBar-Private.h"

@interface GGTabBarTests : XCTestCase

@end

@implementation GGTabBarTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

/** Manually craft an expected dictionary and compare it with the generated dictionary
 */
- (void)testHorizontalLayoutGeneration
{
    // Build TabBar Buttons
    UIButton *btn1 = [[UIButton alloc] init];
    UIButton *btn2 = [[UIButton alloc] init];
    UIButton *btn3 = [[UIButton alloc] init];
    btn1.tag = 99;
    btn2.tag = 100;
    btn3.tag = 101;

    // Build Separator Views
    UIView *sep1 = [[UIView alloc] init];
    UIView *sep2 = [[UIView alloc] init];
    sep1.tag = 3;
    sep2.tag = 4;

    // Build Margin Separators
    UIView *marginSep1 = [[UIView alloc] init];
    UIView *marginSep2 = [[UIView alloc] init];
    marginSep1.tag = 6;
    marginSep2.tag = 7;

    GGTabBar *tabBar = [[GGTabBar alloc] init];

    // Generate a views dictionary for Visual Format Layout Constraints.
    NSDictionary *viewsDictionary;
    viewsDictionary = [tabBar visualFormatStringViewsDictionaryWithButtons:@[btn1, btn2, btn3]
                                                                separators:@[sep1, sep2]
                                                          marginSeparators:@[marginSep1, marginSep2]];

    XCTAssertEqual([[viewsDictionary allKeys] count], 7);

    NSDictionary *expectedDict = @{[NSString stringWithFormat:@"button%ld", (long)btn1.tag] : btn1,
                                   [NSString stringWithFormat:@"button%ld", (long)btn2.tag] : btn2,
                                   [NSString stringWithFormat:@"button%ld", (long)btn3.tag] : btn3,
                                   [NSString stringWithFormat:@"separator%ld", (long)sep1.tag] :sep1,
                                   [NSString stringWithFormat:@"separator%ld", (long)sep2.tag] :sep2,
                                   [NSString stringWithFormat:@"marginSeparator%ld", (long)marginSep1.tag] : marginSep1,
                                   [NSString stringWithFormat:@"marginSeparator%ld", (long)marginSep2.tag] : marginSep2};

    XCTAssertEqualObjects(viewsDictionary, expectedDict);
}


- (void)testHorizontalLayoutConstraintGeneration
{
    GGTabBar *tabBar = [[GGTabBar alloc] init];

    // Build TabBar Buttons
    UIButton *b1 = [[UIButton alloc] init];
    UIButton *b2 = [[UIButton alloc] init];
    UIButton *b3 = [[UIButton alloc] init];
    b1.tag = 1;
    b2.tag = 2;
    b3.tag = 3;

    // Build Separators
    UIView *sep1 = [[UIView alloc] init];
    UIView *sep2 = [[UIView alloc] init];
    sep1.tag = 4;
    sep2.tag = 5;

    // Build Margin Separators
    UIView *marginSep1 = [[UIView alloc] init];
    UIView *marginSep2 = [[UIView alloc] init];
    marginSep1.tag = 1;
    marginSep2.tag = 2;

    // Create a mocked views dictionary (should be equivalent to the one generated by
    // tabBarController viewsDictionaryWithButtons:separators:
    NSDictionary *viewsDictionary;
    viewsDictionary = @{@"button1" : b1,
                        @"button2" : b2,
                        @"button3" : b3,
                        @"separator1" : sep1,
                        @"separator2" : sep2,
                        @"marginSeparator1" : marginSep1,
                        @"marginSeparator2" : marginSep2};

    NSString *constraint;
    constraint = [tabBar visualFormatConstraintStringWithButtons:@[b1, b2, b3]
                                                      separators:@[sep1, sep2]
                                                marginSeparators:@[marginSep1, marginSep2]];

    NSString *expectedConstraint;
    expectedConstraint = @"H:|[marginSeparator1][button1][separator4][button2][separator5][button3][marginSeparator2]|";

    XCTAssertEqualObjects(expectedConstraint, constraint);
}

@end
