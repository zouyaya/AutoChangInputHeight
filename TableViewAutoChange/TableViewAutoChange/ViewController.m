//
//  ViewController.m
//  TableViewAutoChange
//
//  Created by yangou on 2020/4/10.
//  Copyright © 2020 hello. All rights reserved.
//

#import "ViewController.h"
#import "TableViewInputViewCell.h"


#define k_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define k_ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,TableViewInputViewCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
//记录内容
@property (strong, nonatomic) NSString *contentInfoString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    [self initialzieViewUI];
    
    
}



#pragma mark --------------------相关初始化
/**
 初始化页面
 */
-(void)initialzieViewUI
{
    [self.view addSubview:self.tableView];

}




#pragma mark --------------------相关代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     TableViewInputViewCell * cell = (TableViewInputViewCell *)[tableView.dataSource tableView:_tableView cellForRowAtIndexPath:indexPath];
    if ([cell CellHeight] < 70) {
        
         return 70;
        
    }else{
        
        return [cell CellHeight];
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 100;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.0001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, k_ScreenWidth, 100)];
    headerView.backgroundColor = [UIColor redColor];
    return headerView;
    

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TableViewInputViewCell *cell = [TableViewInputViewCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.tableView = _tableView;
    cell.contentStr= _contentInfoString;
    return cell;
    
    
}

#pragma mark ------TableViewInputViewCellDelegate
-(void)updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
    _contentInfoString = text;
    
    
    
}

#pragma mark --------------------懒加载
-(UITableView *)tableView
{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, k_ScreenWidth, k_ScreenWidth) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }

    return _tableView;
    
}

@end
