//
//  VRBCardTableViewCell.h
//  VRBCards
//
//  Created by Andrew on 3/25/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRBCard.h"

@interface VRBCardTableViewCell : UITableViewCell
- (void)configureWithCard:(VRBCard *)card;
@end
