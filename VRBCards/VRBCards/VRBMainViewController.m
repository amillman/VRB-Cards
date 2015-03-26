//
//  VRBMainViewController.m
//  VRBCards
//
//  Created by Andrew on 3/24/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "VRBMainViewController.h"
#import "VRBMainView.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "VRBCard.h"
#import "VRBConstants.h"
#import "VRBCardTableViewCell.h"

@interface VRBMainViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) VRBMainView *view;
@property (nonatomic) NSMutableArray *cards;
@end

@implementation VRBMainViewController

static NSString *REQUEST_URL = @"https://gist.githubusercontent.com/helloandrewpark/0a407d7c681b833d6b49/raw/5f3936dd524d32ed03953f616e19740bba920bcd/gistfile1.js";

#pragma mark - View LifeCycle

- (void)loadView {
    self.view = [[VRBMainView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.cardsTableView.delegate = self;
    self.view.cardsTableView.dataSource = self;
    [self _getCards];
}

- (void)_getCards {
    
    // Do this to accept the specific given link
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    __weak __typeof(self)weakSelf = self;
    [manager GET:REQUEST_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.cards = [[NSMutableArray alloc] init];
        NSDictionary *responseDictionary = responseObject;
        NSArray *cardsArrayJSON = responseDictionary[@"cards"];
        
        for (NSDictionary *cardJSON in cardsArrayJSON) {
            Class cardClass = [VRBCard classFromCardType:cardJSON[@"type"]];
            VRBCard *card;
            
            // Instantiate the specific card based on its cardType, which
            // determine's the card's class. If the specific card
            // type is not valid (e.g. API update), then instantiate a general
            // card and only store the general info (e.g. title, imageURL).
            if (cardClass) {
                card = [MTLJSONAdapter modelOfClass:cardClass fromJSONDictionary:cardJSON error:nil];
            } else {
                card = [MTLJSONAdapter modelOfClass:[VRBCard class] fromJSONDictionary:cardJSON error:nil];
            }
            [strongSelf.cards addObject:card];
        }
        [self.view.cardsTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark - UITableView Delegate / DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cards count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VRBCard *card = self.cards[indexPath.row];
    VRBCardTableViewCell *cellView = [tableView dequeueReusableCellWithIdentifier:card.type];
    [cellView cancelImageRequests];
    
    if (!cellView) {
        cellView = [[VRBCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:card.type];
    }
    [cellView configureWithCard:card];
    
    return cellView;
}

@end
