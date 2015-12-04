//
//  ProfileViewController.h
//  SoprtTimer
//
//  Created by YuesongWang on 3/26/14.
//  Copyright (c) 2014 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) NSString * height;
@property (strong, nonatomic) NSString * weight;
@property (strong, nonatomic) IBOutlet UITextField *tHeight;
@property (strong, nonatomic) IBOutlet UITextField *tWeight;

@end
