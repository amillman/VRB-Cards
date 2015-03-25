//
//  VRBCard.m
//  VRBCards
//
//  Created by Andrew on 3/25/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "VRBCard.h"

@implementation VRBCard

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}

+ (Class)classFromCardType:(NSString *)cardType {
    cardType = [[cardType capitalizedString] stringByAppendingString:@"Card"];
    NSString *CLASS_PREFIX = @"VRB";
    NSString *classNameString = [CLASS_PREFIX stringByAppendingString:cardType];
    return NSClassFromString(classNameString);
}

@end
