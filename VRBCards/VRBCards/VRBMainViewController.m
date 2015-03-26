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
#import <CoreLocation/CoreLocation.h>

@interface VRBMainViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
@property (nonatomic) VRBMainView *view;
@property (nonatomic) NSMutableArray *cards;
@property (nonatomic) CLLocationManager *locationManager;
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
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self _getLocationAndGetCards];
}

- (void)_getLocationAndGetCards {
    [self.locationManager startUpdatingLocation];
}

// Called after user authorizes location-enabled services
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
        [self.view hideLoadingViews];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Error"
                                   message:@"Could not get cards"
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
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

#pragma mark - CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorized || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.view showLoadingViews];
        [self _getCards];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // Most recent location
    CLLocation *userLocation = [locations lastObject];
    [self.locationManager stopUpdatingLocation];
    [self.view configureWithLocation:userLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error"
                               message:@"Failed to Get Your Location"
                               delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil];
    [errorAlert show];
}

@end
