//
//  UILabel+AnimatedNumber.m
//  AnimatedLabel
//
//  Created by Steve on 13-10-7.
//  Copyright (c) 2013年 Steve. All rights reserved.
//

#import "UILabel+AnimatedNumber.h"

//@implementation UILabel (AnimatedNumber)
//
//-(void)animate:(id)sender
//{
//    self.number += self.step;
//    if(self.number > self.target){
//        self.text = [@(self.number) stringValue];
//        [self.timer invalidate];
////        [self.timer release];
//    }
//    else
//        self.text = [@(self.number) stringValue];
//    
//}
//
//-(void)startAnimateTo:(int)i
//{
//    int cycles = 100;
//    self.target = i;
//    self.number = [self.text intValue];
//    int span = i - self.number;
//    self.step = span/cycles;
//    
//    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(animate:) userInfo:nil repeats:YES];
//    
//}
//
//-(void)startAnimateToNumber:(NSNumber *)n
//{
//    [self startAnimateTo:[n intValue]];
//}
//
//@end

@implementation AnimatedLabel

@synthesize target, step, number, timer, initNumber;

-(void)animate:(id)sender
{
    NSLog(@"timer ticking");
    self.initNumber += self.step;
    if(self.initNumber > self.target){
        self.text = [@(self.initNumber) stringValue];
        [self.timer invalidate];
    }
    else
        self.text = [@(self.initNumber) stringValue];

}

-(void)startAnimateTo:(int)i
{
    int cycles = 100;
    self.target = i;
    self.number = [self.text intValue];
    int span = i - self.number;
    self.step = 1;
    self.text = [@(initNumber) stringValue];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.010 target:self selector:@selector(animate:) userInfo:nil repeats:YES];
}

-(void)startAnimateToNumber:(NSNumber *)n
{
    [self startAnimateTo:[n intValue]];
}

@end
