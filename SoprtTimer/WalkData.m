//
//  WalkData.m
//  SoprtTimer
//
//  Created by YuesongWang on 3/10/14.
//  Copyright (c) 2014 Fan's Mac. All rights reserved.
//

#import "WalkData.h"

#define precison 0.74
#define frequencyOfTimer 2

@implementation WalkData {

    int countPrepareForMaxMin;
    int type;
    CGFloat testingMax_x;
    CGFloat testingMin_x;
    CGFloat testingMax_y;
    CGFloat testingMin_y;
    CGFloat testingMax_z;
    CGFloat testingMin_z;
    CGFloat dynamicThreshold;
    CGFloat dynamicThreshold_x;
    CGFloat dynamicThreshold_y;
    CGFloat dynamicThreshold_z;
    CGFloat sample_old;
    CGFloat sample_new;
    CGFloat sample_result_;
    CGFloat sample_old_x;
    CGFloat sample_new_x;
    CGFloat sample_old_y;
    CGFloat sample_new_y;
    CGFloat sample_old_z;
    CGFloat sample_new_z;
    CGFloat sample_result_x;
    CGFloat sample_result_y;
    CGFloat sample_result_z;


    NSTimer * timer;
    int old_countOfStep;
//    NSMutableArray *calary;
       CGFloat time;

}

-(WalkData *) init {
//    [super init];
    self = [super init];
    timer = [NSTimer scheduledTimerWithTimeInterval:frequencyOfTimer target:self selector:@selector(refreshStep) userInfo:nil repeats:YES];
//Set REFRESH STEP
    
    
    // setHeight
    self.height = 1.7;
    self.weight = 50;
    self.speed = 0;
    self.calary = [[NSMutableArray alloc] init];
    self.update_count=0;
    self.last_update_count=0;
    return self;
}

-(void) refreshStep {
    float difx= self.max_x - self.min_x;
    float dify= self.max_y - self.min_y;
    float difz= self.max_z - self.min_z;
    if(difx>dify && difx>difz){
        type=0;
        dynamicThreshold = dynamicThreshold_x;
    }
    if(dify>difx && dify>difz){
        type=1;
        dynamicThreshold = dynamicThreshold_y;
    }
    if(difz>difx && difz>dify){
        type=2;
        dynamicThreshold = dynamicThreshold_z;
    }

    
    int stepPerTwoSecond = self.countOfStep - old_countOfStep;
    old_countOfStep = self.countOfStep;
    CGFloat lengthOfOneStep = 0;
    if (stepPerTwoSecond > 0 && stepPerTwoSecond <= 2) {
        lengthOfOneStep = self.height/5;
    } else if (stepPerTwoSecond >2 && stepPerTwoSecond <= 3){
        lengthOfOneStep = self.height/4;
    } else if (stepPerTwoSecond >3 && stepPerTwoSecond <= 4){
        lengthOfOneStep = self.height/3;
    } else if (stepPerTwoSecond >4 && stepPerTwoSecond <= 5){
        lengthOfOneStep = self.height/2;
    } else if (stepPerTwoSecond >5 && stepPerTwoSecond <= 6){
        lengthOfOneStep = self.height/1.2;
    } else if (stepPerTwoSecond >6 && stepPerTwoSecond <= 8){
        lengthOfOneStep = self.height;
    } else if (stepPerTwoSecond >8){
        lengthOfOneStep = self.height*1.2;
    }
    self.speed = (float)(stepPerTwoSecond * lengthOfOneStep) / (float)(frequencyOfTimer);
    NSLog(@" speed: %0.2f", self.speed);
    
    
    [self.array_speed addObject:[[NSString alloc] initWithFormat:@"%.2f", self.speed]];
    

    
    //Refresh Calories Array
    CGFloat m = self.speed;
    if (m == 0) {
        m = 1;
    } else {
        m *= 4.5;
    }
    
    
    [self.calary addObject:[[NSString alloc] initWithFormat:@"%.2f",  m * self.weight /1800.0]];
   // [self getSumCalary];
    self.distance += self.speed * frequencyOfTimer;
    
}


-(CGFloat) getSumOfMutableArray:(NSMutableArray *)array{
    CGFloat sum = 0;
    //time = frequencyOfTimer * [array count];

    for (NSString *o in array)
    {
        sum += [o floatValue];
    }
    //[array removeAllObjects];
    [array addObject:[[NSString alloc] initWithFormat:@"%.2f",sum]];
    return sum;
}



-(CGFloat) getSumCalary  //Get sum of calary and sum up the existing values
{
    CGFloat f =[self getSumOfMutableArray:self.calary];
    [self.calary removeAllObjects];
    [self.calary addObject:[[NSString alloc] initWithFormat:@"%.2f",f]];
    
    return f;
}




-(void) prepareMaxMinWithValue:(CGFloat)x y:(CGFloat)y z:(CGFloat)z
{
    //NSLog(@"prepareWithValue");
    sample_result_x = x;
    sample_result_y = y;
    sample_result_z = z;

    [self countStep];
    if (countPrepareForMaxMin < 50)
    {
        if (testingMax_x < x) {
            testingMax_x = x;
        }
        if (testingMin_x > x) {
            testingMin_x = x;
        }
        if (testingMax_y < y) {
            testingMax_y = y;
        }
        if (testingMin_y > y) {
            testingMin_y = y;
        }
        if (testingMax_z < z) {
            testingMax_z = z;
        }
        if (testingMin_z > z) {
            testingMin_z = z;
        }
        countPrepareForMaxMin++;
        self.update_count++;

    } else {
        
        countPrepareForMaxMin = 0;
        self.max_x = testingMax_x;
        self.min_x = testingMin_x;
        testingMin_x = 0;
        testingMax_x = 0;
        dynamicThreshold_x = (self.max_x + self.min_x) /2;
        self.max_y = testingMax_y;
        self.min_y = testingMin_y;
        testingMin_y = 0;
        testingMax_y = 0;
        dynamicThreshold_y = (self.max_y + self.min_y) /2;
        self.max_z = testingMax_z;
        self.min_z = testingMin_z;
        testingMin_z = 0;
        testingMax_z = 0;
        dynamicThreshold_z = (self.max_z + self.min_z) /2;
//        NSLog(@"max = %.04f, min = %.04f, threshold = %.04f", self.max, self.min, dynamicThreshold);
    }
}

- (void) countStep
{
//    NSLog(@"countStep");
    sample_old_x = sample_new_x;
    sample_old_y = sample_new_y;
    sample_old_z = sample_new_z;

    float acc_change_x = (sample_result_x-sample_new_x>0) ? sample_result_x- sample_new_x : sample_new_x - sample_result_x;
    if (acc_change_x > precison)
    {
        sample_new_x = sample_result_x;
    }
    float acc_change_y = (sample_result_y-sample_new_y>0) ? sample_result_y- sample_new_y : sample_new_y - sample_result_y;
    if (acc_change_y > precison)
    {
        sample_new_y = sample_result_y;
    }
    float acc_change_z = (sample_result_z-sample_new_z>0) ? sample_result_z- sample_new_z : sample_new_z - sample_result_z;
    if (acc_change_z > precison)
    {
        sample_new_z = sample_result_z;
    }
    //    NSLog(@"old:%f, new:%f, result:%f", sample_old, sample_new, sample_result);
    
    if(type==0){
        sample_old = sample_old_x;
        sample_new = sample_new_x;
    }
    if(type==1){
        sample_old = sample_old_y;
        sample_new = sample_new_y;
    }
    if(type==2){
        sample_old = sample_old_z;
        sample_new = sample_new_z;
    }
    
    if (sample_new < sample_old && sample_new < dynamicThreshold && sample_old > dynamicThreshold)
    {
        int window =(self.update_count-self.last_update_count);
        NSLog(@"%d,%d", self.update_count,self.last_update_count);

        if(window >2 && window<250){
            self.countOfStep++;

            self.update_count=0;
            
        }
        self.last_update_count = self.update_count;
        
     //   NSLog(@"x=%d y=%d z=%d", acc_change_x,acc_change_y, acc_change_z);
        NSLog(@"%d", self.countOfStep);
    }
//    NSLog(@"%d", self.countOfStep);
}

@end
