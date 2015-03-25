//
//  VRBMovieCard.m
//  VRBCards
//
//  Created by Andrew on 3/25/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "VRBMovieCard.h"

@implementation VRBMovieCard

+ (NSValueTransformer *)movieExtraImageURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
