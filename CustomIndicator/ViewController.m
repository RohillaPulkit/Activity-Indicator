//
//  ViewController.m
//  CustomIndicator
//
//  Created by Pulkit Rohilla on 09/04/15.
//  Copyright (c) 2015 PulkitRohilla. All rights reserved.
//

#import "ViewController.h"
#import "IndicatorView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAnimation:(UIBarButtonItem *)sender {
    
    [IndicatorView addIndicatorOn:self];
}

- (IBAction)stopAnimation:(id)sender {
    
    [IndicatorView removeIndicator];
}
@end
