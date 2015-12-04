//
//  TouchDrawView.m
//  TouchTracker
//
//  Created by YuesongWang on 2/27/14.
//  Copyright (c) 2014 Storm Max. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"

@implementation TouchDrawView
#define Cheng 10
#define Jia  40
-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

-(id)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    if(self){
        linesInProgress = [[ NSMutableDictionary alloc] init];
        completeLines=[[NSMutableArray alloc] init];
        XLines=[[NSMutableArray alloc] init];
        YLines=[[NSMutableArray alloc] init];
        ZLines=[[NSMutableArray alloc] init];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
      
        
        pOld.x=[self getRandomNumberBetween:300 to:400];
        pOld.y=[self getRandomNumberBetween:300 to:400];
        pOld.z=[self getRandomNumberBetween:300 to:400];
        
        
        pNew.x=[self getRandomNumberBetween:300 to:400];
        pNew.y=[self getRandomNumberBetween:300 to:400];
        pNew.z=[self getRandomNumberBetween:300 to:400];
        
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(draw:) userInfo:nil repeats:YES];
        
     
        
    }
    flag=YES;
    
    return self;
}



-(void)draw:(id)sender
{
    [self drawTo:pNew.x y:pNew.y z:pNew.z];
}
- (void) To:(CGFloat)x y:(CGFloat)y z:(CGFloat)z {
    pNew.x = x * Cheng + Jia;
    pNew.y = y * Cheng + Jia;
    pNew.z = z * Cheng + Jia;
}
-(void)drawTo:(CGFloat)x y:(CGFloat)y z:(CGFloat)z{
    CGPoint begin;
    CGPoint end;
    for(Line * l in XLines){
        begin=[l begin];
        end=[l end];
        begin.x+=10;
        end.x+=10;
        [l setBegin:begin];
        [l setEnd:end];
    }
    for(Line * l in YLines){
        begin=[l begin];
        end=[l end];
        begin.x+=10;
        end.x+=10;
        [l setBegin:begin];
        [l setEnd:end];
    }
    for(Line * l in ZLines){
        begin=[l begin];
        end=[l end];
        begin.x+=10;
        end.x+=10;
        [l setBegin:begin];
        [l setEnd:end];
    }
    
    Line *newLineX=[[Line alloc] init];
    [newLineX setBegin:CGPointMake(0, x/2)];
    [newLineX setEnd:CGPointMake(10, pOld.x/2)];
    [XLines addObject:newLineX];
    
    Line *newLineY=[[Line alloc] init];
    [newLineY setBegin:CGPointMake(0, y/2)];
    [newLineY setEnd:CGPointMake(10, pOld.y/2)];
    [YLines addObject:newLineY];
    
    Line *newLineZ=[[Line alloc] init];
    [newLineZ setBegin:CGPointMake(0, z/2)];
    [newLineZ setEnd:CGPointMake(10, pOld.z/2)];
    [ZLines addObject:newLineZ];
    
    pOld.x=x;
    pOld.y=y;
    pOld.z=z;
    
    [self setNeedsDisplay];
}

-(void)drawline:(id)sender
{
    CGPoint begin;
    CGPoint end;
    for(Line * l in completeLines){
        begin=[l begin];
        end=[l end];
        begin.x+=10;
        end.x+=10;
        [l setBegin:begin];
        [l setEnd:end];
    }
    
    if(flag==YES){
        flag=NO;
        begin=CGPointMake(0, 320);
        end=CGPointMake(10, 330);
    }else{
        flag=YES;
        begin=CGPointMake(0, 330);
        end=CGPointMake(10, 320);
    }
    Line *newLine=[[Line alloc] init];
    [newLine setBegin:begin];
    [newLine setEnd:end];
    [completeLines addObject:newLine];
    
    [self setNeedsDisplay];
}





-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)deleteLine:(id)sender
{
    [completeLines removeObject:[self selectedLine]];
    [self setNeedsDisplay];
}





-(void)drawRect:(CGRect)rect{
    
    
    
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    [[UIColor blackColor] set];
    for(Line *line in completeLines){
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
    
    [[UIColor blueColor] set];
    for(Line *line in XLines){
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
    
    [[UIColor greenColor] set];
    for(Line *line in YLines){
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
    
    [[UIColor redColor] set];
    for(Line *line in ZLines){
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
    
    
    
    
    if([self selectedLine]){
        [[UIColor greenColor] set];
        CGContextMoveToPoint(context, [[self selectedLine] begin].x,[[self selectedLine] begin].y );
        CGContextAddLineToPoint(context, [[self selectedLine] end].x, [[self selectedLine] end].y);
        CGContextStrokePath(context);
    }
}

-(void)clearAll
{
    [linesInProgress removeAllObjects];
    [completeLines removeAllObjects];
    
    [self setNeedsDisplay];
}

-(Line *)lineAtPoint:(CGPoint)p
{
    for(Line *l in completeLines){
        CGPoint start=[l begin];
        CGPoint end=[l end];
        
        for(float t =0.0 ;t<=1.0;t+=0.05){
            float x=start.x+t*(end.x-start.x);
            float y=start.y+t*(end.y-start.y);
            
            if(hypot(x-p.x,y-p.y)<20.0){
                return l;
            }
        }
    }
    return nil;
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   // [self endTouches:touches];
    
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
   // [self endTouches:touches];
}


-(int)numberOfLines
{
    int count=0;
    
    if(linesInProgress && completeLines){
        count=[linesInProgress count]+[completeLines count];
    }
    return count;
}

@end
