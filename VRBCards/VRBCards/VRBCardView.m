//
//  VRBCardView.m
//  VRBCards
//
//  Created by Andrew on 3/25/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "VRBCardView.h"
#import "VRBConstants.h"
#import "Masonry.h"
#import "UIImageView+AFNetworking.h"

@implementation VRBCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self _createSubviews];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)dealloc {
    [self cancelImageRequests];
}

- (void)_createSubviews {
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:21.0f];
    _titleLabel.numberOfLines = 2;
    [self addSubview:_titleLabel];
    
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.font = [UIFont systemFontOfSize:15.0f];
    _typeLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
    [self addSubview:_typeLabel];
    
    _thumbnailImageView = [[UIImageView alloc] init];
    _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    _thumbnailImageView.layer.cornerRadius = 5.0f;
    _thumbnailImageView.clipsToBounds = YES;
    [self addSubview:_thumbnailImageView];
    
}

- (void)updateConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thumbnailImageView.mas_top);
        make.leading.equalTo(_thumbnailImageView.mas_trailing).with.offset(STANDARD_MARGIN);
        make.trailing.equalTo(@(-STANDARD_MARGIN));
    }];
    
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.leading.equalTo(_titleLabel.mas_leading);
        make.trailing.equalTo(_titleLabel.mas_trailing);
    }];
    
    [_thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(STANDARD_MARGIN));
        make.leading.equalTo(@(STANDARD_MARGIN));
        make.height.equalTo(@120);
        make.width.equalTo(@120);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public Methods

- (void)configureWithCard:(VRBCard *)card {
    _titleLabel.text = card.title;
    _typeLabel.text = [card.type capitalizedString];
    [_thumbnailImageView setImageWithURL:card.imageURL];
}

- (void)cancelImageRequests {
    [_thumbnailImageView cancelImageRequestOperation];
    _thumbnailImageView.image = nil;
}

+ (Class)viewClassFromCardType:(NSString *)cardType {
    cardType = [[cardType capitalizedString] stringByAppendingString:@"CardView"];
    NSString *classNameString = [CLASS_PREFIX stringByAppendingString:cardType];
    return NSClassFromString(classNameString);
}

@end
