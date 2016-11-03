//
//  DetailViewController.m
//  Note
//
//  Created by 李恺林 on 2016/11/2.
//  Copyright © 2016年 李恺林. All rights reserved.
//

#import "DetailViewController.h"
#import "RootTableViewController.h"

@interface DetailViewController ()<UIAlertViewDelegate>

@property UITextView *inputTextView;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.inputTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, 310, 320)];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSString *oldtext = [array objectAtIndex:self.index];
    self.inputTextView.text = oldtext;
    UIBarButtonItem *savebtn = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(saveclicked)];
    UIBarButtonItem *delbtn = [[UIBarButtonItem alloc]initWithTitle:@"delete" style:UIBarButtonItemStylePlain target:self action:@selector(deleteclicked)];
    NSArray *bararray = [NSArray arrayWithObjects:delbtn,savebtn, nil];
    self.navigationItem.rightBarButtonItems = bararray;
    [self.view addSubview:self.inputTextView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveclicked{
    NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSMutableArray *mutableArray = [tempArray mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *now = [NSDate date];
    NSString *datestring = [dateFormatter stringFromDate:now];
    NSString *textstring = [self.inputTextView text];
    [mutableArray removeObjectAtIndex:self.index];
    [mutableArray insertObject:textstring atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
    RootTableViewController *rootctrl = [[RootTableViewController alloc]init];
    rootctrl.noteArray = mutableArray;
    
    NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
    [mutableDateArray removeObjectAtIndex:self.index];
    [mutableDateArray insertObject:datestring atIndex:0 ];
    rootctrl.dateArray = mutableDateArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
    [self.inputTextView resignFirstResponder];
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:nil
                                message:@"Save success!"
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noButton = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];}

-(void)deleteclicked{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Are you sure to delete this note?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alertView show];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
        NSMutableArray *mutableArray = [tempArray mutableCopy];
        [mutableArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
        RootTableViewController *rootctrl = [[RootTableViewController alloc]init];
        rootctrl.noteArray = mutableArray;
        
        NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
        NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
        [mutableDateArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
        rootctrl.dateArray = mutableDateArray;
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (buttonIndex == 1) return;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
