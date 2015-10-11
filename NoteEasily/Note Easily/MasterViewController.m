//
//  MasterTableViewController.m
//  Note Easily
//
//  Created by xixixi on 15/8/21.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()
{
    DetailViewController *_detailViewController;
    NSDictionary *_dic;
    //定义一个数组保存单元格主标题
    NSMutableArray *_titleArray;
    //定义一个数组保存单元格副标题
    NSMutableArray *_timeArray;
    //定义一个数组保存搜索匹配的title结果
    NSMutableArray *_searchTitleArray;
    //定义一个数组保存搜索匹配的time结果
    NSMutableArray *_searchTimeArray;
    //定义BOOL值 代表是否是在搜索
    BOOL _isSearch;
    
}

@end

@implementation MasterViewController

- (void)viewDidLoad {
    _isSearch = NO;
    [super viewDidLoad];
        //为tableView设置委托对象
    self.table.delegate = self;
    self.table.dataSource = self;
    self.searchBar.delegate = self;
    _detailViewController = [[DetailViewController alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //获取应用程序委托对象
    AppDelegate *appDelegete = [UIApplication sharedApplication].delegate;
    _titleArray = appDelegete.titleArray;
    _timeArray = appDelegete.timeArray;
    [self.table reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //如果处于搜索状态
    if (_isSearch) {
        
    }
    //为表格行定义一个静态字符串作为标示符
    static NSString *cellId = @"cellId";
    //从可重用表格队列中取出一个表格行
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    //如果取出的表格行为nil
    if (!cell) {
        //创建一个UITableViewCell对象，使用UITableViewCellStyleSubtitle风格
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:cellId];
    }
    //从indexPath中获取当前的行号
    NSUInteger rowNo = indexPath.row;
    if (_isSearch) {
        //取出_searchTitleArray中索引为rowNo的元素作为UITableViewCell的文本标题
        cell.textLabel.text = _searchTitleArray[rowNo];
        //取出_searchTimeArray中索引为rowNo的元素作为UItableviewCell的详细内容
        cell.detailTextLabel.text = _searchTimeArray[rowNo];
    }else {
    //取出titleArray中索引为rowNo的元素作为UITableViewCell的文本标题
    cell.textLabel.text = _titleArray[rowNo];
    //取出timeArray中索引为rowNo的元素作为UItableviewCell的详细内容
    cell.detailTextLabel.text = _timeArray[rowNo];
    }
    return cell;
 }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //如果处于搜索状态
    if (_isSearch) {
        return _searchTitleArray.count;
    }

    return _titleArray.count;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        //获取当前点击行号
        NSIndexPath *indexPath = [self.table indexPathForCell:sender];
        NSInteger rowNo = indexPath.row;
        //获取目标控制器
        id destController = segue.destinationViewController;
        [destController setValue:_titleArray[rowNo] forKey:@"text"];
        [destController setValue:_timeArray[rowNo] forKey:@"time"];
        [destController setValue:[NSNumber numberWithInteger:rowNo] forKey:@"rowNo"];

    }
}

//该方法的返回值决定单元格的编辑状态
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return  UITableViewCellEditingStyleDelete;
}

//该方法返回值作为删除指定行时确认按钮上的文本
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"确认删除";
}

//该方法返回值决定某行是否可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//移动完成时激发该方法
- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSInteger sourceRowNo = [sourceIndexPath row];
    NSInteger destRowNo = [destinationIndexPath row];
    //获取要移动的数据
    NSString *title = _titleArray[sourceRowNo];
    NSString *time = _timeArray[sourceRowNo];
    //从底层数据中删除指定的数据项
    [_titleArray removeObjectAtIndex:sourceRowNo];
    [_timeArray removeObjectAtIndex:sourceRowNo];
    //将移动的数据插入指定位置
    [_titleArray insertObject:title atIndex:destRowNo];
    [_timeArray insertObject:time atIndex:destRowNo];

}

//编辑完成时激发该方法
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowNo = [indexPath row];
    //从底层数据中删除指定的数据项
    [_titleArray removeObjectAtIndex:rowNo];
    [_timeArray removeObjectAtIndex:rowNo];
    
    //从table表中删除指定行
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)add:(id)sender {
    
    self.table.editing = NO;
    [self.removeButton setTitle:@"编辑" forState:UIControlStateNormal];
}

- (IBAction)remove:(id)sender
{
    if ([_titleArray count] == 0 && [self.removeButton.currentTitle isEqualToString:@"编辑" ]
                                 && self.table.editing == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"对不起"
                                                        message:@"您还没有添加备忘录！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
    }
    else{
        //该变当前编辑状态
        [self.table setEditing:!self.table.editing animated:YES];
        //如果当前处于编辑状态
        if (self.table.editing) {
            //修改删除按钮上的文本
            [self.removeButton setTitle:@"完成" forState:UIControlStateNormal];
        }
        else
        {
            //修改删除按钮上的文本
            [self.removeButton setTitle:@"编辑" forState:UIControlStateNormal];

        }
    }
}
//当单击搜索条的取消按钮时激发该方法
- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //取消搜索状态
    _isSearch = NO;
    [self.table reloadData];
}

//当用户点击键盘上的search按键时激发该方法
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //调用filerBySubtring：方法执行搜索
    [self filerBySubtring:searchBar.text];
    //放弃作为第一响应者，关闭键盘
    [searchBar resignFirstResponder];
}

-(void) filerBySubtring:(NSString *)subStr
{
    //设置搜索状态
    _isSearch = YES;
    //定义搜索谓词
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@" , subStr];
    //使用谓词过滤
    NSMutableArray *_searchData = [_titleArray copy];
    [_searchData filterUsingPredicate:pred];
    _searchTitleArray = _searchData;
    //让表格重新加载数据
    [self.table reloadData];
}


@end
