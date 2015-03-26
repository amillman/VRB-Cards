//
//  VRBPlaceCardView.m
//  VRBCards
//
//  Created by Andrew on 3/25/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "VRBPlaceCardView.h"
#import "VRBConstants.h"
#import "Masonry.h"
#import "UIImageView+AFNetworking.h"
#import "VRBPlaceCard.h"


@implementation VRBPlaceCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.thumbnailImageView.mas_bottom);
        make.leading.equalTo(self.thumbnailImageView.mas_trailing).with.offset(STANDARD_MARGIN);
        make.trailing.equalTo(@(-STANDARD_MARGIN));
    }];
    
    [super updateConstraints];
}

#pragma mark - Public Methods

- (void)createSubviews {
    [super createSubviews];
    
    _categoryLabel = [[UILabel alloc] init];
    _categoryLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _categoryLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self addSubview:_categoryLabel];
}

- (void)configureWithCard:(VRBCard *)card {
    [super configureWithCard:card];
    VRBPlaceCard *placeCard = (VRBPlaceCard *)card;
    _categoryLabel.text = placeCard.placeCategory;
}

@end
