//
//  ViewController.m
//  AnimatedLabel
//
//  Created by Steve on 13-10-7.
//  Copyright (c) 2013年 Steve. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, retain) NSTimer* timer;

@end

@implementation ViewController
@synthesize animLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [animLabel setInitNumber: 100];
    [animLabel startAnimateTo:200];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
