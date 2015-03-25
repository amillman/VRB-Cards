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

@interface VRBMainViewController ()
@property (nonatomic) VRBMainView *view;
@property (nonatomic) NSMutableArray *cards;
@end

@implementation VRBMainViewController

- (void)loadView {
    self.view = [[VRBMainView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _getCards];
}

- (void)_getCards {
    NSString *REQUEST_URL = @"https://gist.githubusercontent.com/helloandrewpark/0a407d7c681b833d6b49/raw/5f3936dd524d32ed03953f616e19740bba920bcd/gistfile1.js";
    
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
            VRBCard *card = [MTLJSONAdapter modelOfClass:cardClass fromJSONDictionary:cardJSON error:nil];
            [strongSelf.cards addObject:card];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
