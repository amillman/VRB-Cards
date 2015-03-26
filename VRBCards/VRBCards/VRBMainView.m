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
    _cardsTableView.tableHeaderView = [[UIView alloc] init];
    _cardsTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_cardsTableView];
    
}

- (void)updateConstraints {
    
    [_cardsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NAVBAR_HEIGHT));
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [super updateConstraints];
}

@end
