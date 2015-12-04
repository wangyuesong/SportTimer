//
//  WalkData.h
//  SoprtTimer
//
//  Created by YuesongWang on 3/10/14.
//  Copyright (c) 2014 Fan's Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalkData : NSObject


@property (nonatomic) CGFloat max_x;
@property (nonatomic) CGFloat min_x;
@property (nonatomic) CGFloat max_y;
@property (nonatomic) CGFloat min_y;
@property (nonatomic) CGFloat max_z;
@property (nonatomic) CGFloat min_z;
@property (nonatomic) int countOfStep;
@property (nonatomic) int last_update_count;
@property (nonatomic) int update_count;
@property (nonatomic) int learn;
@property (nonatomic) CGFloat distance;
@property (nonatomic) CGFloat speed;
@property (strong, nonatomic) NSMutableArray *calary;
@property (strong, nonatomic) NSMutableArray *array_speed;
-(void) prepareMaxMinWithValue:(CGFloat)value y:(CGFloat)y z:(CGFloat)z;
-(WalkData *) init;
@property CGFloat height;
@property CGFloat weight;

-(CGFloat) getSumCalary;

@end
