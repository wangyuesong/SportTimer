//
//  ViewController.m
//  SoprtTimer
//
//  Created by YuesongWang on 2/27/14.
//  Copyright (c) 2014 Fan's Mac. All rights reserved.
//
#import "ViewController.h"

#define frequencyOfTimer 0.1


@interface ViewController ()
@end

@implementation ViewController {
    BOOL isCountingTime;
    CGFloat x;
    CGFloat y;
    CGFloat z;
    NSTimer * timer;
    
    CGFloat timeConsumed;
    //Used to store the time consuming from start
}





-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)refreshTimeCount  //Here to refresh time counting by 0.1sec
{
    if(isCountingTime)
    {
    timeConsumed += 0.1;
    self.lTimeCount.text = [NSString stringWithFormat:@"%0.1f",timeConsumed];
    }
}


- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    

    //Set time counting, 0.1s
    [NSTimer scheduledTimerWithTimeInterval:frequencyOfTimer target:self selector:@selector(refreshTimeCount) userInfo:nil repeats:YES];
    [self.tabBarItem setImage:[UIImage imageNamed:@"walk.png"]];
    self.walkData = [[WalkData alloc] init];
    NSArray *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [ doc objectAtIndex:0 ];
    if( [[NSFileManager defaultManager] fileExistsAtPath:[docPath stringByAppendingPathComponent:@"Data.plist"] ]==NO )
    {
        NSMutableDictionary *newDic = [ [ NSMutableDictionary alloc ] init ];
        // 新数据
        // 将新的dic里的“Score”项里的数据写为“newScore”
        [ newDic setValue:@"175" forKey:@"height" ];
        [ newDic setValue:@"60" forKey:@"weight" ];
        // 将　newDic　保存至docPath＋“Score.plist”文件里，也就是覆盖原来的文件
        
        [ newDic writeToFile:[docPath stringByAppendingPathComponent:@"Data.plist"] atomically:YES ];

    }
    
       NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[docPath stringByAppendingPathComponent:@"Data.plist"]]; // 解析数据
    
    NSString *weight = [ dic objectForKey:@"weight" ];
    NSString *height = [dic objectForKey:@"height"];
   
    self.walkData.height = height.floatValue/100;
    self.walkData.weight = weight.floatValue;
    
    self.drawView = [[TouchDrawView alloc] initWithFrame:CGRectMake(60, 80, 200, 50)];
    [self.view addSubview:self.drawView];

	// Erase the view when recieving a notification named "shake" from the NSNotificationCenter object
	// The "shake" nofification is posted by the PaintingWindow object when user shakes the device
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shakeAction) name:@"shake" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeState) name:@"stateChange" object:nil];
    
   
    
    self.motionManager = [[CMMotionManager alloc] init];
    if ([self.motionManager isAccelerometerAvailable])
    {
        [self.motionManager setAccelerometerUpdateInterval:1.0f/50.0f];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
        {
            x = accelerometerData.acceleration.x;
            y = accelerometerData.acceleration.y;
            z = accelerometerData.acceleration.z;


            [self.drawView To:x y:y z:z];
          
            
                [[NSNotificationCenter defaultCenter] postNotificationName:@"stateChange" object:self];
            }];
        
    } else {
        NSLog(@"Accelerometer is not available.");
    }
}

-(void) changeState //Every 0.02s will be called by notification
{
//    isCountingTime = !isCountingTime;
//    self.state.text = @"Running";
//    NSLog(@" %s", isCountingTime ? "true" : "false");
    if (!isCountingTime)
    {

    }
    else
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //加入耗时操作
            //......
        
            [self.walkData prepareMaxMinWithValue:x y:y z:z];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //更新UI操作
                //.....
                self.lStepsCount.text = [NSString stringWithFormat:@"%d", self.walkData.countOfStep];
                self.lSpped.text = [NSString stringWithFormat:@"%0.1f",self.walkData.speed];
                self.lCaloriesCount.text = [NSString stringWithFormat:@"%0.1f",[self.walkData getSumCalary]];
                self.lDistanceCount.text = [NSString stringWithFormat:@"%0.1f",self.walkData.distance];
                
            });
        });
//        self.state.text = @"Running";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 晃动执行入口
-(void) shakeAction
{
//    NSLog(@"Shaked");
}


#pragma mark Shake

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake )
	{
		// User was shaking the device. Post a notification named "shake".
		[[NSNotificationCenter defaultCenter] postNotificationName:@"shake" object:self];
	}
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
}



//- (IBAction)testInstanceCalary:(id)sender {
//    NSLog(@"calary: %0.2f, instance: %0.2f", [self.walkData getInstance], [self.walkData getSumCalary]);
//}


//Database performing

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)bStartClicked:(id)sender {
    
    isCountingTime = YES;
}

- (IBAction)bStopClicked:(id)sender {
    isCountingTime = NO;
}

- (IBAction)bStoreAndClearClicked:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
     NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
   
  
   
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];//这里去掉 具体时间 保留日期
    NSString *dateNow = [NSString stringWithFormat:@"%@",[formater stringFromDate:[NSDate date]]];

    NSString *predicateString = [NSString stringWithFormat:@"date = '%@'",dateNow];
    NSPredicate * qcondition= [NSPredicate predicateWithFormat:predicateString];
   
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DailyWorkOutData" inManagedObjectContext:managedObjectContext];
    
   
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:qcondition];
    [fetchRequest setFetchBatchSize:20];
    NSArray *objecs = [context executeFetchRequest: fetchRequest error:nil];
    
    if([objecs count] == 0)
        //First time  add this date
    {
        
        NSManagedObject * newData = [NSEntityDescription insertNewObjectForEntityForName:@"DailyWorkOutData"
        inManagedObjectContext:context];
        [newData setValue:dateNow forKey:@"date"];
        [newData setValue:self.lCaloriesCount.text forKey:@"calories"];
        [newData setValue:self.lStepsCount.text forKey:@"steps"];
        [newData setValue:self.lTimeCount.text forKey:@"workoutTime"];
        [newData setValue:self.lDistanceCount.text forKey:@"distance"];

       
        
      
    }
    
    else //Already Have it
    {
        NSManagedObject * oldData = [objecs objectAtIndex:0];        
        [oldData setValue:dateNow forKey:@"date"];
        NSString * newCaloriesCount = [NSString stringWithFormat:@"%0.1f",[self.lCaloriesCount.text floatValue] + [[oldData valueForKey:@"calories"] floatValue]];
         NSString * newStepsCount = [NSString stringWithFormat:@"%d",[self.lStepsCount.text intValue] + [[oldData valueForKey:@"steps"] intValue]];
        NSString * newWorkoutTimeCount = [NSString stringWithFormat:@"%0.1f",[self.lTimeCount.text floatValue] + [[oldData valueForKey:@"steps"] floatValue]];
        NSString * newDistance = [NSString stringWithFormat:@"%0.1f",[self.lDistanceCount.text floatValue]+[[oldData valueForKey:@"distance"]floatValue]];
        
        [oldData setValue:newCaloriesCount forKey:@"calories"];
        [oldData setValue:newStepsCount forKey:@"steps"];
        [oldData setValue:newWorkoutTimeCount forKey:@"workoutTime"];
        [oldData setValue:newDistance forKey:@"distance"];
        
       
    }

     NSError *error = nil;
    if(![context save:&error])
        NSLog(@"cannot save!");
//    [self dismissViewControllerAnimated:YES completion:nil];
    

    //Now clear it!
    self.walkData.countOfStep = 0;
    self.walkData.speed = 0;
    [self.walkData.calary removeAllObjects];
    timeConsumed = 0;
    self.walkData.distance=0;
    
     self.lStepsCount.text = @"0";
    self.lSpped.text = @"0";
    self.lCaloriesCount.text = @"0";
    self.lTimeCount.text = @"0";
    self.lDistanceCount.text = @"0";

    isCountingTime = NO;
}


//When it come back from Profile View
- (IBAction)saveSegue:(UIStoryboardSegue *)segue
{
  
    ProfileViewController * p = segue.sourceViewController;
    NSString * height = p.tHeight.text;
    NSString * weight = p.tWeight.text;

    NSArray *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [ doc objectAtIndex:0 ];
//    if( [[NSFileManager defaultManager] fileExistsAtPath:[docPathstringByAppendingPathComponent:@"Data.plist"] ]==NO ) {
        NSMutableDictionary *newDic = [ [ NSMutableDictionary alloc ] init ];
        // 新数据
        // 将新的dic里的“Score”项里的数据写为“newScore”
        [ newDic setValue:height forKey:@"height" ];
        [ newDic setValue:weight forKey:@"weight" ];
        // 将　newDic　保存至docPath＋“Score.plist”文件里，也就是覆盖原来的文件
    self.walkData.height = [height floatValue]/100;
    self.walkData.weight = [weight floatValue];
        [ newDic writeToFile:[docPath stringByAppendingPathComponent:@"Data.plist"] atomically:YES ];
        // ============================== 写入plist初始化数据（最后有，先说读取）
//    }
//
//    path = [[NSBundle mainBundle] pathForResource:@"Data" s:@"plist"];
//    array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
//    NSLog(@"array:%@",[array objectAtIndex:0]);
    
}

- (IBAction)cancelSegue:(UIStoryboardSegue *)segue
{
    
   
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    ProfileViewController * p =[[[segue destinationViewController] viewControllers] objectAtIndex:0];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSArray *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [ doc objectAtIndex:0 ]; // 字典集合。
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[docPath stringByAppendingPathComponent:@"Data.plist"]]; // 解析数据
    
    NSString *weight = [ dic objectForKey:@"weight" ];
    NSString *height = [dic objectForKey:@"height"];
//    NSArray *array = [ content componentsSeparatedByString:@","];
    height =  [dic objectForKey:@"height"];
    weight =  [dic objectForKey:@"weight"];
    p.height = height;
    p.weight = weight;
}


@end
