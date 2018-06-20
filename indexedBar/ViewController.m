//
//  ViewController.m
//  indexedBar
//
//  Created by Paean on 2018/6/13.
//  Copyright © 2018年 蒋晨成. All rights reserved.
//

#import "ViewController.h"
#import "IndexedTableView.h"
@interface ViewController ()<IndexedBarDataSource,UITableViewDelegate,UITableViewDataSource>

{
    IndexedTableView *tableView;
    NSMutableArray *dataSource;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 20, self.view.frame.size.width, 40);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"reloadTable" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    tableView = [[IndexedTableView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.indexedBarDataSource = self;
    [self.view addSubview:tableView];
    
    dataSource = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [dataSource addObject:@(i)];
    }
    
    
    
}

- (void)buttonAction:(UIButton *)button {
    [tableView reloadData];
}

#pragma mark --- UITableViewDataSource ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_id = @"resueID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = [dataSource[indexPath.row] stringValue];
    return cell;
}


#pragma mark --- IndexedBarDataSource ---
- (NSArray<NSString *> *)indexTitlesForIndexedTableView:(IndexedTableView *)tableView {
    static BOOL change = YES;
    if (change) {
        change = NO;
        return @[@"A",@"B",@"C",@"D",@"E",@"F"];
        
    }else {
        change = YES;
         return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H"];
    }
}


@end
