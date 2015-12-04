//
//  AnimationViewController.m
//  SoprtTimer
//
//  Created by YuesongWang on 3/18/14.
//  Copyright (c) 2014 Fan's Mac. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *animation;

@end

@implementation AnimationViewController

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
    // Do any additional setup after loading the view.
//    self.animation.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"animation.jpg"], nil];
//    [self.animation setAnimationDuration:2];
//    [self.animation setAnimationRepeatCount:1];
//    [self.animation startAnimating];
//
    [self performSelector:@selector(showMainMenu) withObject:nil afterDelay:2.0];
}

- (void)showMainMenu {
    [self performSegueWithIdentifier:@"animationSegue" sender:self];
    [self resignFirstResponder];
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
