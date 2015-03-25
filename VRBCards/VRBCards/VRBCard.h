//
//  VRBCard.h
//  VRBCards
//
//  Created by Andrew on 3/25/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

/** ================ ABSTRACT CLASS ================ **/

@interface VRBCard : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *type;
@property (nonatomic) NSURL *imageURL;


/**
 Returns the Class of a card based on its NSString type.
    e.g. @"place" returns VRBPlaceCard
 
 @param cardType The NSString of a card's type
 
 */

+ (Class)classFromCardType:(NSString *)cardType;


@end
