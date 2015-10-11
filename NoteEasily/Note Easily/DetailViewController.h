//
//  EditViewController.h
//  Note Easily
//
//  Created by xixixi on 15/8/21.
//  Copyright (c) 2015年 xihao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
#import "AddViewController.h"
@interface DetailViewController: UIViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
/**
 *  编辑界面 内容文本
 */
@property (strong, nonatomic) IBOutlet UITextView *textDetail;
/**
 *  编辑界面 时间文本
 */
@property (strong, nonatomic) IBOutlet UITextField *timeText;
//定义属性保存上一个控制器传递的值
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger rowNo;
- (IBAction)edit:(UIBarButtonItem *)sender;

@end
