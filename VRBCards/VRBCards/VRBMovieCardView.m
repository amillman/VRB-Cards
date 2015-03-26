//
//  VRBMovieCardView.m
//  VRBCards
//
//  Created by Andrew on 3/25/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "VRBMovieCardView.h"
#import "VRBConstants.h"
#import "Masonry.h"
#import "UIImageView+AFNetworking.h"
#import "VRBMovieCard.h"


@implementation VRBMovieCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _addSubviews];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)_addSubviews {
    
    _extraImageView = [[UIImageView alloc] init];
    _extraImageView.contentMode = UIViewContentModeScaleAspectFill;
    _extraImageView.layer.cornerRadius = 5.0f;
    _extraImageView.clipsToBounds = YES;
    [self addSubview:_extraImageView];
}

- (void)updateConstraints {
    
    [_extraImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.thumbnailImageView.mas_bottom);
        make.leading.equalTo(self.thumbnailImageView.mas_trailing).with.offset(STANDARD_MARGIN);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public Methods

- (void)configureWithCard:(VRBCard *)card {
    [super configureWithCard:card];
    VRBMovieCard *movieCard = (VRBMovieCard *)card;
    [_extraImageView setImageWithURL:movieCard.movieExtraImageURL];
}

- (void)cancelImageRequests {
    [super cancelImageRequests];
    [_extraImageView cancelImageRequestOperation];
    _extraImageView.image = nil;
}

@end
