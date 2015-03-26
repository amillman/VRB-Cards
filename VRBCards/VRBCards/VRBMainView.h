//
//  VRBMainView.h
//  VRBCards
//
//  Created by Andrew on 3/24/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface VRBMainView : UIView
@property (nonatomic) UITableView *cardsTableView;
- (void)showLoadingViews;
- (void)hideLoadingViews;
- (void)configureWithLocation:(CLLocation *)location;
@end
