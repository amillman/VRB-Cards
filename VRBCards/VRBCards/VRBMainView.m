//
//  VRBMainView.m
//  VRBCards
//
//  Created by Andrew on 3/24/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "VRBMainView.h"
#import "Masonry.h"
#import "VRBConstants.h"

@interface VRBMainView ()
@property (nonatomic) UIView *navBarView;
@property (nonatomic) UILabel *latitudeWordLabel;
@property (nonatomic) UILabel *longitudeWordLabel;
@property (nonatomic) UILabel *latitudeNumberLabel;
@property (nonatomic) UILabel *longitudeNumberLabel;
@property (nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation VRBMainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self _createSubviews];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)_createSubviews {
    
    _cardsTableView = [[UITableView alloc] init];
    _cardsTableView.separatorColor = [UIColor clearColor];
    _cardsTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_cardsTableView];
    
    _navBarView = [[UIView alloc] init];
    _navBarView.backgroundColor = [UIColor whiteColor];
    _navBarView.layer.masksToBounds = NO;
    _navBarView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    _navBarView.layer.shadowRadius = 4.0f;
    _navBarView.layer.shadowOpacity = 0.3f;
    [self addSubview:_navBarView];
    
    _latitudeWordLabel = [[UILabel alloc] init];
    _latitudeWordLabel.font = [UIFont systemFontOfSize:10.0f];
    _latitudeWordLabel.text = @"Latitude";
    _latitudeWordLabel.textAlignment = NSTextAlignmentCenter;
    [_navBarView addSubview:_latitudeWordLabel];
    
    _longitudeWordLabel = [[UILabel alloc] init];
    _longitudeWordLabel.font = [UIFont systemFontOfSize:10.0f];
    _longitudeWordLabel.text = @"Longitude";
    _longitudeWordLabel.textAlignment = NSTextAlignmentCenter;
    [_navBarView addSubview:_longitudeWordLabel];
    
    _latitudeNumberLabel = [[UILabel alloc] init];
    _latitudeNumberLabel.font = [UIFont systemFontOfSize:16.0f];
    _latitudeNumberLabel.text = @"--";
    _latitudeNumberLabel.textAlignment = NSTextAlignmentCenter;
    [_navBarView addSubview:_latitudeNumberLabel];
    
    _longitudeNumberLabel = [[UILabel alloc] init];
    _longitudeNumberLabel.font = [UIFont systemFontOfSize:16.0f];
    _longitudeNumberLabel.text = @"--";
    _longitudeNumberLabel.textAlignment = NSTextAlignmentCenter;
    [_navBarView addSubview:_longitudeNumberLabel];
    
    _loadingView =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:_loadingView];
}

- (void)updateConstraints {
    
    [_cardsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NAVBAR_HEIGHT));
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [_navBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.height.equalTo(@(NAVBAR_HEIGHT));
    }];
    
    [_latitudeWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_latitudeNumberLabel.mas_leading);
        make.trailing.equalTo(_latitudeNumberLabel.mas_trailing);
        make.bottom.equalTo(_latitudeNumberLabel.mas_top);
    }];
    
    [_longitudeWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_longitudeNumberLabel.mas_leading);
        make.trailing.equalTo(_longitudeNumberLabel.mas_trailing);
        make.bottom.equalTo(_longitudeNumberLabel.mas_top);
    }];
    
    [_latitudeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@(TIGHT_MARGIN));
        make.trailing.equalTo(_navBarView.mas_centerX).with.offset(-TIGHT_MARGIN);
        make.bottom.equalTo(@(-TIGHT_MARGIN));
        make.height.equalTo(@(20));
    }];
    
    [_longitudeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_navBarView.mas_centerX).with.offset(TIGHT_MARGIN);
        make.trailing.equalTo(@(TIGHT_MARGIN));
        make.bottom.equalTo(@(-TIGHT_MARGIN));
        make.height.equalTo(@(20));
    }];
    
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBarView.mas_bottom).with.offset(STANDARD_MARGIN * 2);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public Methods

- (void)showLoadingViews {
    _latitudeNumberLabel.text = @"Getting...";
    _longitudeNumberLabel.text = @"Getting...";
    [_loadingView startAnimating];
}

- (void)hideLoadingViews {
    [_loadingView stopAnimating];
}

- (void)configureWithLocation:(CLLocation *)location {
    _latitudeNumberLabel.text = [NSString stringWithFormat:@"%.5f", location.coordinate.latitude];
    _longitudeNumberLabel.text = [NSString stringWithFormat:@"%.5f", location.coordinate.longitude];
}

@end
