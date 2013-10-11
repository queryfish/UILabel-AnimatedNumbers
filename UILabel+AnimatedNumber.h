//
//  UILabel+AnimatedNumber.h
//  AnimatedLabel
//
//  Created by Steve on 13-10-7.
//  Copyright (c) 2013年 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimatedLabel : UILabel
{
    int number;
    int step;
    int target;
    int initNumber;
    NSTimer * timer;
    
}

@property (nonatomic, assign) int number;
@property (nonatomic, assign) int step;
@property (nonatomic, assign) int target;
@property (nonatomic, assign) int initNumber;

@property (nonatomic, retain) NSTimer * timer;

-(void) startAnimateToNumber:(NSNumber*)n;
-(void) startAnimateTo:(int)i;

@end

//@interface UILabel (AnimatedNumber)
//
//@property (nonatomic, assign) int number;
//@property (nonatomic, assign) int step;
//@property (nonatomic, assign) int target;
//
//@property (nonatomic, retain) NSTimer * timer;
//
//-(void) startAnimateToNumber:(NSNumber*)n;
//-(void) startAnimateTo:(int)i;
//
//@end
