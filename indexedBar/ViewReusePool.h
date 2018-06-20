//
//  ViewReusePool.h
//  indexedBar
//
//  Created by Paean on 2018/6/13.
//  Copyright © 2018年 蒋晨成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 实现重用机制的类
@interface ViewReusePool : NSObject

// 从重用池当中去除一个可重用的view
- (UIView *)dequeueReusableView;

// 向重用池中添加一个视图
- (void)addUsingView:(UIView *)view;

// 重置方法，将当前使用中的试图移动到可重用队列当中
- (void)reset;


@end
