//
//  IndexedTableView.h
//  indexedBar
//
//  Created by Paean on 2018/6/13.
//  Copyright © 2018年 蒋晨成. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndexedTableView;
@protocol IndexedBarDataSource <NSObject>


- (NSArray <NSString *>*)indexTitlesForIndexedTableView:(IndexedTableView *)tableView;

@end


@interface IndexedTableView : UITableView

@property (nonatomic, weak) id<IndexedBarDataSource> indexedBarDataSource;

@end
