//
//  VRBMusicCardView.m
//  VRBCards
//
//  Created by Andrew on 3/25/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "VRBMusicCardView.h"
#import "VRBConstants.h"
#import "Masonry.h"
#import "UIImageView+AFNetworking.h"
#import "VRBMusicCard.h"

@interface VRBMusicCardView ()
@property (nonatomic) NSURL *musicVideoURL;
@end

@implementation VRBMusicCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    
    [_musicVideoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.thumbnailImageView.mas_bottom);
        make.leading.equalTo(self.thumbnailImageView.mas_trailing).with.offset(STANDARD_MARGIN);
        make.trailing.equalTo(@(-STANDARD_MARGIN));
        make.height.equalTo(@30);
    }];
    
    [super updateConstraints];
}

#pragma mark - Music Video Opening

- (void)openMusicVideo {
    [[UIApplication sharedApplication] openURL:_musicVideoURL];
}

#pragma mark - Public Methods

- (void)createSubviews {
    [super createSubviews];
    
    _musicVideoButton = [[UIButton alloc] init];
    [_musicVideoButton addTarget:self action:@selector(openMusicVideo) forControlEvents:UIControlEventTouchUpInside];
    [_musicVideoButton setTitle:@"View Music Video" forState:UIControlStateNormal];
    [_musicVideoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_musicVideoButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.4] forState:UIControlStateHighlighted];
    _musicVideoButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    _musicVideoButton.backgroundColor = [UIColor colorWithRed:0.90 green:0.30 blue:0.23 alpha:1];
    _musicVideoButton.layer.cornerRadius = 3.0f;
    _musicVideoButton.clipsToBounds = YES;
    [self addSubview:_musicVideoButton];
}

- (void)configureWithCard:(VRBCard *)card {
    [super configureWithCard:card];
    VRBMusicCard *movieCard = (VRBMusicCard *)card;
    _musicVideoURL = movieCard.musicVideoURL;
}


@end
