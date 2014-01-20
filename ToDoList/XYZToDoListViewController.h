//
//  XYZToDoListViewController.h
//  ToDoList
//
//  Created by DX167-XL on 2014-01-13.
//  Copyright (c) 2014 DX167-XL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZToDoListViewController : UITableViewController<NSURLConnectionDataDelegate>{
    NSMutableData *_responseData;
}
- (IBAction)refresh:(id)sender;



@end
