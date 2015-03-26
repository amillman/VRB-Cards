//
//  VRBCardTableViewCell.m
//  VRBCards
//
//  Created by Andrew on 3/25/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "VRBCardTableViewCell.h"
#import "VRBCardView.h"
#import "Masonry.h"

@interface VRBCardTableViewCell ()
@property (nonatomic) VRBCardView *cardView;
@end

@implementation VRBCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self _createSubviewsWithReuseIdentifier:reuseIdentifier];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)_createSubviewsWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    // Instantiate the specific cardView based on the reuseIdentifier, which
    // is equal to the cardType of a VRBCard instance. If the specific card
    // type is not valid (e.g. API update), then instantiate a general
    // cardView.
    Class cardViewClass = [VRBCardView viewClassFromCardType:reuseIdentifier];
    if (cardViewClass) {
        _cardView = [[cardViewClass alloc] init];
    } else {
        _cardView = [[VRBCardView alloc] init];
    }
    [self.contentView addSubview:_cardView];
}

- (void)updateConstraints {
    
    [_cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(STANDARD_MARGIN / 2));
        make.leading.equalTo(@(STANDARD_MARGIN));
        make.trailing.equalTo(@(-STANDARD_MARGIN));
        make.bottom.equalTo(@(-STANDARD_MARGIN / 2));
    }];
    
    [super updateConstraints];
}

# pragma mark - Public Methods

- (void)configureWithCard:(VRBCard *)card {
    [_cardView configureWithCard:card];
}

- (void)cancelImageRequests {
    [_cardView cancelImageRequests];
}

@end
