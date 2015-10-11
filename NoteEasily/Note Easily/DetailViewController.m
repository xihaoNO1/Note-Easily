//
//  EditViewController.m
//  Note Easily
//
//  Created by xixixi on 15/8/21.
//  Copyright (c) 2015年 xihao. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
}
- (void)viewWillAppear:(BOOL)animated
{
    //设置文本框内容
    self.textDetail.text = self.text;
    self.timeText.text = self.time;
    //设置默认不准编辑
    self.textDetail.editable = NO;
    self.timeText.enabled = NO;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)edit:(UIBarButtonItem *)sender {
    //如果按钮上的文本为编辑
    if ([[sender title] isEqualToString:@"编辑"]) {
        //设置titleText和timeTitle允许被修改
        self.textDetail.editable = YES;
        /**
         *  时间显示文本 考虑需不需要
         */
//        self.timeText.enabled = NO;
        
        //设置按钮上文本为完成
        [self.editButton setTitle:@"完成"];
    }
    else{
        //获取当前应用程序委托代理
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        //获取格式化时间
        NSDate *date = [NSDate date];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
        dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        NSString *theDate = [dateFormatter stringFromDate:date];
        //修改应用程序的titlArray属性和timeArray属性
        [appDelegate.titleArray replaceObjectAtIndex:self.rowNo withObject:self.textDetail.text];
        [appDelegate.timeArray replaceObjectAtIndex:self.rowNo withObject:theDate];
        self.textDetail.editable = NO;
    }
    
}
@end
