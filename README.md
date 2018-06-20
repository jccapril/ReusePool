# ReusePool

简书：https://www.jianshu.com/p/ecacf354ca37


### 前言
[自定义复用池加载字母索引条](https://github.com/jccapril/ReusePool)
帮助大家理解iOS复用池原理



## 1、 ViewReusePool

*在ViewReusePool定义一个等待队列和一个使用队列，每次创建一个对象会先从等待队列中获取，
并将其放入使用队列，如果等待队列中没有可以使用的对象，将会创建对象。

*ViewReusePool.h
```
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

```
*ViewReusePool.m
```
#import "ViewReusePool.h"

@interface ViewReusePool()

// 等待使用的队列
@property (nonatomic, strong) NSMutableSet *waitUsedQueue;

// 使用中的队列
@property (nonatomic, strong) NSMutableSet *usingQueue;

@end

@implementation ViewReusePool

- (instancetype)init {
self = [super init];
if (self) {
_waitUsedQueue = [NSMutableSet set];
_usingQueue = [NSMutableSet set];
}
return self;
}


- (UIView *)dequeueReusableView {
UIView *view = [_waitUsedQueue anyObject];
if (view == nil) {
return nil;
}else {
// 进行队列移动
[_waitUsedQueue removeObject:view];
[_usingQueue addObject:view];
return view;
}

}


- (void)addUsingView:(UIView *)view {
if (view == nil) {
return;
}
// 添加视图到使用中的队列
[_usingQueue addObject:view];

}

- (void)reset {
UIView *view = nil;
while ((view = [_usingQueue anyObject])) {
// 从使用中的队列中移除
[_usingQueue removeObject:view];
// 加入等待使用的队列
[_waitUsedQueue addObject:view];
}
}

```


*使用案例
```


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



}


```






