//
//  AppDelegate.h
//  SoprtTimer
//
//  Created by YuesongWang on 2/27/14.
//  Copyright (c) 2014 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface AppDelegate : NSObject <UIApplicationDelegate> {
       /* (...Existing Application Code...) */
}

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) UIWindow *window;
/* (...Existing Application Code...) */


@end
