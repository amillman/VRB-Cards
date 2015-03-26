//
//  VRBCardView.h
//  VRBCards
//
//  Created by Andrew on 3/25/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRBConstants.h"
#import "VRBCard.h"

@interface VRBCardView : UIView

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *typeLabel;
@property (nonatomic) UIImageView *thumbnailImageView;

- (void)configureWithCard:(VRBCard *)card;
- (void)cancelImageRequests;

/**
 Returns the Class of a cardView based on its NSString type.
 e.g. @"place" returns VRBPlaceCardView
 
 @param cardType The NSString of a card's type
 
 */

+ (Class)viewClassFromCardType:(NSString *)cardType;


@end
