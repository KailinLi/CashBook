//
//  AddNoteViewController.m
//  Note
//
//  Created by 李恺林 on 2016/11/2.
//  Copyright © 2016年 李恺林. All rights reserved.
//

#import "AddNoteViewController.h"
#import "RootTableViewController.h"

@interface AddNoteViewController ()

@property UITextView *inputTextView;

@end

@implementation AddNoteViewController

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
    
    self.inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, 310, 320)];
    [self.view addSubview:self.inputTextView];
    [self.inputTextView becomeFirstResponder];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(saveclicked)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveclicked{
    NSMutableArray *initNoteArray = [[NSMutableArray alloc]init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"note"]==nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initNoteArray forKey:@"note"];
    }
    NSArray *tempNoteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSMutableArray *mutableNoteArray = [tempNoteArray mutableCopy];
    NSString *textstring = [self.inputTextView text];
    [mutableNoteArray insertObject:textstring atIndex:0 ];
    RootTableViewController *rootctrl = [[RootTableViewController alloc]init];
    rootctrl.noteArray = mutableNoteArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableNoteArray forKey:@"note"];
    
    NSMutableArray *initDateArray = [[NSMutableArray alloc]init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"date"]==nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initDateArray forKey:@"date"];
    }
    NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *now = [NSDate date];
    NSString *datestring = [dateFormatter stringFromDate:now];
    [mutableDateArray insertObject:datestring atIndex:0 ];
    rootctrl.dateArray = mutableDateArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
    
    [self.inputTextView resignFirstResponder];
    UIAlertController *alert = [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:@"Add success!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noButton = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
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
