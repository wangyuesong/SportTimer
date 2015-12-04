//
//  TableViewController.m
//  SoprtTimer
//
//  Created by YuesongWang on 3/15/14.
//  Copyright (c) 2014 Fan's Mac. All rights reserved.
//

#import "TableViewController.h"
#import "DailyDetailViewController.h"
@interface TableViewController ()
{
    NSManagedObjectContext * context;
    NSFetchRequest * fetchRequest;
    NSEntityDescription * entity;
    
    NSInteger searchBarScope;
}
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    context = [self managedObjectContext];
    fetchRequest = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"DailyWorkOutData" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    context = [self managedObjectContext];
    
//    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
   
    NSArray *objecs = [context executeFetchRequest: fetchRequest error:nil];
    self.dateList = objecs.mutableCopy;
    //Configure the datalist
    [self.tableView reloadData];

}
- (void)viewDidLoad
{
    self.searchBar.delegate = self;
    
  
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.dateList count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSManagedObject *oneDate = [self.dateList objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",[oneDate valueForKey:@"date"]]];
    NSString * calleft = [NSString stringWithFormat:@"%0.2f",[[oneDate valueForKey:@"input"]floatValue] - [[oneDate valueForKey:@"calories"] floatValue]];
    NSString * leftover = @"Calorie Budget: ";
    leftover = [leftover stringByAppendingString:calleft];
    
    [cell.detailTextLabel setText:leftover];

    return cell;
}


- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    NSLog(@"textDidChange---%@",searchBar.text);
//    [liveViewAreaTable searchDataBySearchString:searchBar.text];// 搜索tableView数据
//    [self controlAccessoryView:0];// 隐藏遮盖层。
//
    if(searchBarScope == 0)
    {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"date contains %@",searchText];
    fetchRequest.predicate = pred;
      NSArray *objecs = [context executeFetchRequest: fetchRequest error:nil];
    self.dateList = objecs.mutableCopy;
    //Configure the datalist
    [self.tableView reloadData];
    }
    else if(searchBarScope ==1)
    {
        NSString * format = [NSString stringWithFormat:@"date like '%@-??-??'",searchText];
        NSPredicate *pred = [NSPredicate predicateWithFormat:format];
        fetchRequest.predicate = pred;
         NSLog(@"%@",pred.description);
        NSArray *objecs = [context executeFetchRequest: fetchRequest error:nil];
        self.dateList = objecs.mutableCopy;
        //Configure the datalist
        [self.tableView reloadData];
    }
    else if(searchBarScope ==2)
    {
        NSString * format = [NSString stringWithFormat:@"date like '????-%@-??'",searchText];
        NSPredicate *pred = [NSPredicate predicateWithFormat:format];
        NSLog(@"%@",pred.description);
        fetchRequest.predicate = pred;
        NSArray *objecs = [context executeFetchRequest: fetchRequest error:nil];
        self.dateList = objecs.mutableCopy;
        //Configure the datalist
        [self.tableView reloadData];
    }
    else if(searchBarScope ==3)
    {
        NSString * format = [NSString stringWithFormat:@"date like '????-??-%@'",searchText];
        NSPredicate *pred = [NSPredicate predicateWithFormat:format];
        fetchRequest.predicate = pred;
        NSArray *objecs = [context executeFetchRequest: fetchRequest error:nil];
        self.dateList = objecs.mutableCopy;
        //Configure the datalist
        [self.tableView reloadData];
    }
    NSLog(@"Text change");
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *searchText = searchBar.text;
    if(searchBarScope == 0)
    {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"date contains %@",searchText];
        fetchRequest.predicate = pred;
        NSArray *objecs = [context executeFetchRequest: fetchRequest error:nil];
        self.dateList = objecs.mutableCopy;
        //Configure the datalist
        [self.tableView reloadData];
    }
    else if(searchBarScope ==1)
    {
        NSString * format = [NSString stringWithFormat:@"date like '%@-??-??'",searchText];
        NSPredicate *pred = [NSPredicate predicateWithFormat:format];
        fetchRequest.predicate = pred;
        NSLog(@"%@",pred.description);
        NSArray *objecs = [context executeFetchRequest: fetchRequest error:nil];
        self.dateList = objecs.mutableCopy;
        //Configure the datalist
        [self.tableView reloadData];
    }
    else if(searchBarScope ==2)
    {
        NSString * format = [NSString stringWithFormat:@"date like '????-%@-??'",searchText];
        NSPredicate *pred = [NSPredicate predicateWithFormat:format];
        NSLog(@"%@",pred.description);
        fetchRequest.predicate = pred;
        NSArray *objecs = [context executeFetchRequest: fetchRequest error:nil];
        self.dateList = objecs.mutableCopy;
        //Configure the datalist
        [self.tableView reloadData];
    }
    else if(searchBarScope ==3)
    {
        NSString * format = [NSString stringWithFormat:@"date like '????-??-%@'",searchText];
        NSPredicate *pred = [NSPredicate predicateWithFormat:format];
        fetchRequest.predicate = pred;
        NSArray *objecs = [context executeFetchRequest: fetchRequest error:nil];
        self.dateList = objecs.mutableCopy;
        //Configure the datalist
        [self.tableView reloadData];
    }
    NSLog(@"Text change");
    [searchBar resignFirstResponder];
    
}
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    searchBarScope = selectedScope;
    NSLog(@"Scope now %i",selectedScope );
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (IBAction)cancelSegue:(UIStoryboardSegue *)segue
{
}

- (IBAction)saveSegue:(UIStoryboardSegue *)segue
{
     DailyDetailViewController * d =  [segue sourceViewController];
        NSString *s = d.tCalorieInput.text;
        [d.dateObject setValue:s forKey:@"input"];
      
        NSLog(@"%@",[d.dateObject valueForKey:@"input"]);
        NSError *error = nil;
        if(![context save: &error])
        {
            NSLog(@"Cannot save");
        }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"ShowDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [self.dateList objectAtIndex:indexPath.row];
//        NSLog(@"%d",indexPath.row);
//        NSLog(@"%@",[[object valueForKey:@"date"] stringValue]);
//        NSLog(@"%@",[[segue destinationViewController] name]);
        [[[[segue destinationViewController] viewControllers] objectAtIndex:0 ] setDateObject:object];

    }
    
    
    
}


@end
