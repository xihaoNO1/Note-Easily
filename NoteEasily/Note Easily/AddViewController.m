//
//  AddViewController.m
//  Note Easily
//
//  Created by xixixi on 15/8/21.
//  Copyright (c) 2015年 xihao. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
{
    //定义一个数组保存添加的内容
    NSMutableArray *textArray;
    //定义一个数组保存添加的时间
    NSMutableArray *timeArray;
    
    MasterViewController *masterViewController;
}

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addText:(id)sender {
    
    NSString *text = self.addText.text;
    //格式化日期
    NSDate *date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *theDate = [dateFormatter stringFromDate:date];
    //获取应用程序,传递文本内容和时间
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.titleArray addObject:text];
    [appDelegate.timeArray addObject:theDate];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"恭喜您"
                                                       message:@"您已成功添加一个备忘录！"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles: nil];
    [alertView show];
}
@end
