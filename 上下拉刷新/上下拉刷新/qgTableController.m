//
//  qgTableController.m
//  上下拉刷新
//
//  Created by Strong on 16/7/6.
//  Copyright © 2016年 strong. All rights reserved.
//

#import "qgTableController.h"
#import <MJRefresh.h>
@interface qgTableController ()

#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation qgTableController
 static NSString *iden = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"上下拉刷新";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:iden];
    
    [self setupRefresh];
}
-(void)setupRefresh{
    
//下拉刷新
 self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
     // 1.添加假数据
     for (int i = 0; i<5; i++) {
         [self.dataArray insertObject:MJRandomData atIndex:0];
     }
     
     // 2.2秒后刷新表格UI
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         // 刷新表格
         [self.tableView reloadData];
         
         // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
         [self.tableView.mj_header endRefreshing];
     });

 }];
//    [self.tableView.mj_header beginRefreshing];
    
    //上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 1.添加假数据
        for (int i = 0; i<5; i++) {
            [self.dataArray addObject:MJRandomData];
        }
        
        // 2.2秒后刷新表格UI
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.tableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        });

    }];
//    [self.tableView.mj_footer beginRefreshing];
}




-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i<12; i++) {
            [self.dataArray addObject:MJRandomData];
        }
    }
    return _dataArray;
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    cell.textLabel.text = self.dataArray [indexPath.row];
    
    return cell;
}



@end
