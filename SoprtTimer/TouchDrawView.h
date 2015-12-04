//
//  TouchDrawView.h
//  TouchTracker
//
//  Created by YuesongWang on 2/27/14.
//  Copyright (c) 2014 Storm Max. All rights reserved.
//

#import <Foundation/Foundation.h>




typedef struct Point3D {
    CGFloat x;
    CGFloat y;
    CGFloat z;
} Point3D;


@class Line;
@interface TouchDrawView : UIView <UIGestureRecognizerDelegate>
{
    NSMutableDictionary *linesInProgress;
    NSMutableArray *completeLines;
    
    NSMutableArray *XLines;
    NSMutableArray *YLines;
    NSMutableArray *ZLines;
    
    UIPanGestureRecognizer *moveRecognizer;
    NSTimer * timer;
    BOOL flag;
    
    Point3D pOld;
    Point3D pNew;
    
}
@property (nonatomic,strong) Line *selectedLine;

-(Line *) lineAtPoint:(CGPoint)p;

-(void)clearAll;
-(void)endTouches:(NSSet *)touches;

//@property (nonatomic, retain) NSTimer * timer;

-(void)drawTo:(CGFloat)x y:(CGFloat)y z:(CGFloat)z;
-(int)getRandomNumberBetween:(int)from to:(int)to;
- (void) To:(CGFloat)x y:(CGFloat)y z:(CGFloat)z;
@end
