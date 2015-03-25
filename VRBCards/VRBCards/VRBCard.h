//
//  VRBCard.h
//  VRBCards
//
//  Created by Andrew on 3/25/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VRBCard : NSObject
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *type;
@property (nonatomic) NSURL *imageURL;
@end
