//
//  MasterTableViewController.h
//  Note Easily
//
//  Created by xixixi on 15/8/21.
//  Copyright (c) 2015年 xihao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "AddViewController.h"

@interface MasterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIButton *removeButton;

- (IBAction)add:(id)sender;

- (IBAction)remove:(id)sender;

@end
