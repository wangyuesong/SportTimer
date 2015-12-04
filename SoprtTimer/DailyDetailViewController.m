//
//  DailyDetailViewController.m
//  SoprtTimer
//
//  Created by YuesongWang on 3/17/14.
//  Copyright (c) 2014 Fan's Mac. All rights reserved.
//

#import "DailyDetailViewController.h"

@interface DailyDetailViewController ()

{
    
}
@end

@implementation DailyDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:[self.dateObject valueForKey:@"date"]];
    NSLog(@"%@",[self.dateObject valueForKey:@"date"]);
    NSString * calorieConsumption = [[self.dateObject valueForKey:@"calories"] stringByAppendingString:@" cal"];
    NSString * workoutTime = [NSString stringWithFormat:@"%0.2f",[[self.dateObject valueForKey:@"workoutTime"] floatValue] / 60.0f] ;
    // Do any additional setup after loading the view.
    workoutTime = [workoutTime stringByAppendingString:@" min"];
    NSString * steps =  [[self.dateObject valueForKey:@"steps"] stringByAppendingString:@" steps"];
    NSString * input = [self.dateObject valueForKey:@"input"];
    NSString * leftover = [NSString stringWithFormat:@"%0.2f",[input floatValue] -[calorieConsumption floatValue] ];
    NSString * distance = [self.dateObject valueForKey:@"distance"];
    if(leftover.floatValue >0)
        [self.lComment setText:@"Come on! Work hard!"];
    else
        [self.lComment setText:@"Good Job! Keep Going!"];
    leftover = [leftover stringByAppendingString:@" Cal"];
    if(input == nil)
        {
            input = @"0";
        }
    
    [self.lCalorieConsumption setText:calorieConsumption];
    [self.lWorkoutTime setText:workoutTime];
    [self.lStepsCount setText:steps];
    [self.tCalorieInput setText:input];
    [self.lLeftOver setText:leftover];
    [self.lDistance setText:distance];
    //Set delegate
    [self.tCalorieInput setDelegate:self];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
