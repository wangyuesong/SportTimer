//
//  DailyDetailViewController.h
//  SoprtTimer
//
//  Created by YuesongWang on 3/17/14.
//  Copyright (c) 2014 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DailyDetailViewController;

//@protocol TextFieldDelegate
//- (void) textFieldLoseFocus:(UITextField *)textField;
//@end

//Text field lose focus delegate

@interface DailyDetailViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lCalorieConsumption;
@property (weak, nonatomic) IBOutlet UITextField *tCalorieInput;
@property (weak, nonatomic) IBOutlet UILabel *lWorkoutTime;
@property (weak, nonatomic) IBOutlet UILabel *lStepsCount;
@property (weak, nonatomic) IBOutlet UILabel *lComment;
@property (weak, nonatomic) IBOutlet UILabel *lLeftOver;
@property (weak, nonatomic) IBOutlet UILabel *lDistance;


@property (strong,nonatomic) NSManagedObject * dateObject;

//@property (weak,nonatomic) id<TextFieldDelegate> delegate;


@end
