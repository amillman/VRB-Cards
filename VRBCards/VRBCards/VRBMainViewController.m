//
//  VRBMainViewController.m
//  VRBCards
//
//  Created by Andrew on 3/24/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "VRBMainViewController.h"
#import "VRBMainView.h"

@interface VRBMainViewController ()
@property (nonatomic) VRBMainView *view;
@end

@implementation VRBMainViewController

- (void)loadView {
    self.view = [[VRBMainView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

@end
