//
//  XYZAddToDoItemViewController.m
//  ToDoList
//
//  Created by DX167-XL on 2014-01-13.
//  Copyright (c) 2014 DX167-XL. All rights reserved.
//

#import "XYZAddToDoItemViewController.h"
#import "XYZToDoListViewController.h"
#import "XYZToDoItem.h"

@interface XYZAddToDoItemViewController () {
    NSString *moviestring;
}

@property (nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *sum;
@property (nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation XYZAddToDoItemViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (sender != self.doneButton) return;
    if (self.textField.text.length > 0){
        self.toDoItem = [[XYZToDoItem alloc] init];
        self.toDoItem.itemName = self.textField.text;
        self.toDoItem.completed = NO;
    }
}
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
    self.sum.text =@"test";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
