//
//  RootTableViewController.m
//  Note
//
//  Created by 李恺林 on 2016/11/2.
//  Copyright © 2016年 李恺林. All rights reserved.
//

#import "RootTableViewController.h"
#import "AddNoteViewController.h"
#import "DetailViewController.h"

@interface RootTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation RootTableViewController

@synthesize noteArray,dateArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.noteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    self.dateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    [self.tableView reloadData]; // to reload selected cell
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addNote)];
    self.navigationItem.rightBarButtonItem = addBtn;
    self.navigationItem.title = @"Write Notes";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [noteArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *note  = nil;
    note = [noteArray objectAtIndex:indexPath.row];
    NSString *date = [dateArray objectAtIndex:indexPath.row];
    NSUInteger charnum = [note length];
    if (charnum < 22) {
        cell.textLabel.text = note;
    }
    else{
        cell.textLabel.text = [[note substringToIndex:18] stringByAppendingString:@"..."];
    }
    cell.detailTextLabel.text = date;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    
    
    return cell;
    
    
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//    if (cell==nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
//    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    NSString *note  = nil;
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        note = [filteredNoteArray objectAtIndex:indexPath.row];
//    }
//    else if(tableView == self.tableView){
//        note = [noteArray objectAtIndex:indexPath.row];
//    };
//    NSString *date = [dateArray objectAtIndex:indexPath.row];
//    NSUInteger charnum = [note length];
//    if (charnum < 22) {
//        cell.textLabel.text = note;
//    }
//    else{
//        cell.textLabel.text = [[note substringToIndex:18] stringByAppendingString:@"..."];
//    }
//    cell.detailTextLabel.text = date;
//    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
//    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *modifyCtrl = [[DetailViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:modifyCtrl animated:NO];
    NSInteger row = [indexPath row];
    modifyCtrl.index = row;
}

- (void)addNote{
    AddNoteViewController *detailViewCtrl = [[AddNoteViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
