//
//  IndexedTableView.m
//  indexedBar
//
//  Created by Paean on 2018/6/13.
//  Copyright © 2018年 蒋晨成. All rights reserved.
//

#import "IndexedTableView.h"
#import "ViewReusePool.h"
@interface IndexedTableView()
{
    UIView *viewContaner;
    ViewReusePool *viewReusePool;
    
}

@end

@implementation IndexedTableView


- (void)reloadData{
    [super reloadData];
    
   
    
    // reload字母索引条
    [self reloadIndexedBar];
}

- (void)reloadIndexedBar{
    if (viewContaner == nil) {
        viewContaner = [[UIView alloc] initWithFrame:CGRectZero];
        viewContaner.backgroundColor = [UIColor whiteColor];
        
        // 避免索引条随着table滚动
        [self.superview insertSubview:viewContaner aboveSubview:self];
    }
    
    if (viewReusePool == nil) {
        viewReusePool = [[ViewReusePool alloc] init];
    }
    
    // 标记所有视图为可重用状态
    [viewReusePool reset];
    
    NSArray <NSString *> *arrayTitles = nil;
    if ([self.indexedBarDataSource respondsToSelector:@selector(indexTitlesForIndexedTableView:)]) {
        arrayTitles = [self.indexedBarDataSource indexTitlesForIndexedTableView:self];
    }
    
    if (!arrayTitles || arrayTitles.count <= 0) {
        [viewContaner setHidden:YES];
        return;
    }
    
    NSUInteger count = arrayTitles.count;
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = self.frame.size.height / count;
    
    for (int i = 0; i < [arrayTitles count]; i++) {
        NSString *title = [arrayTitles objectAtIndex:i];
        // 从重用池当中取一个Button出来
        UIButton *button = (UIButton *)[viewReusePool dequeueReusableView];
        // 如果没有可重用的Buuton重新创建一个
        if (button == nil) {
            button = [[UIButton alloc] initWithFrame:CGRectZero];
            button.backgroundColor = [UIColor whiteColor];
            
            // 注册button到重用池中
            [viewReusePool addUsingView:button];
            NSLog(@"新创建一个Button");
        }else{
            NSLog(@"Button 重用了");
        }
        [viewContaner addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button setFrame:CGRectMake(0, i * buttonHeight, buttonWidth, buttonHeight)];
        
    }
    [viewContaner setHidden:NO];
    viewContaner.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - buttonWidth, self.frame.origin.y, buttonWidth, buttonHeight);
    
    
}







@end
