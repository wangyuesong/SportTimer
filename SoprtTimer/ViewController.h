//
//  ViewController.h
//  SoprtTimer
//
//  Created by YuesongWang on 2/27/14.
//  Copyright (c) 2014 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "ProfileViewController.h"
#import "WalkData.h"
#import "TouchDrawView.h"


@interface ViewController : UIViewController
{
    
    __weak IBOutlet UIImageView *animation;
}

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (strong, nonatomic) WalkData *walkData;
@property (strong, nonatomic) TouchDrawView *drawView;
@property (weak, nonatomic) IBOutlet UILabel *lSpped;
@property (weak, nonatomic) IBOutlet UILabel *lStepsCount;
@property (weak, nonatomic) IBOutlet UILabel *lCaloriesCount;
@property (weak, nonatomic) IBOutlet UILabel *lTimeCount;
@property (weak, nonatomic) IBOutlet UILabel *lDistanceCount;
- (IBAction)bStartClicked:(id)sender;
- (IBAction)bStopClicked:(id)sender;
- (IBAction)bStoreAndClearClicked:(id)sender;

@end
