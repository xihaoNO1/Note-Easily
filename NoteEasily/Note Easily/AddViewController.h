//
//  AddViewController.h
//  Note Easily
//
//  Created by xixixi on 15/8/21.
//  Copyright (c) 2015年 xihao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MasterViewController.h"
#import "DetailViewController.h"

@interface AddViewController : UIViewController
/**
 *  添加备忘录属性
 */
@property (strong, nonatomic) IBOutlet UITextView *addText;

//为添加按钮添加方法
- (IBAction)addText:(id)sender;

@end
