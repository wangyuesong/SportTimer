//
//  TableViewController.h
//  SoprtTimer
//
//  Created by YuesongWang on 3/15/14.
//  Copyright (c) 2014 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,atomic) NSMutableArray *dateList;
@end
