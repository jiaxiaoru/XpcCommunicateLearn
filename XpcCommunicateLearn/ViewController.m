//
//  ViewController.m
//  XpcCommunicateLearn
//
//  Created by Judith on 2019/11/6.
//  Copyright © 2019 Judith. All rights reserved.
//

#import "ViewController.h"
#import "XpcClient.h"

@interface ViewController()

@property XpcClient *xpcClient;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _xpcClient = [[XpcClient alloc] init];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
