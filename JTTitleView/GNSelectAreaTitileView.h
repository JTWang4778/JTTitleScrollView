//
//  GNSelectAreaTitileView.h
//  JTTitleView
//
//  Created by 王锦涛 on 2017/3/18.
//  Copyright © 2017年 JTWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  GNSelectAreaTitileViewDelegate <NSObject>

- (void)didClickTitleWithIndex:(NSInteger)index;
- (void)successAddTitle:(NSString *)title CurrentTag:(NSInteger)tag;

@end
@interface GNSelectAreaTitileView : UIView

/*
    1,更改实现  把所有title放到scrollView中
    2，提供增加title的方法  并且 实现插入动画
    3，增加每一个title 的点击方法  和 动画
    4，提供一个外部设置 当前选中那个title的方法
 */


@property (nonatomic,weak)id <GNSelectAreaTitileViewDelegate> delegate;
@property (nonatomic,assign)NSInteger scrollToIndex;

- (void)addTitle:(NSString *)title WithTableViewTag:(NSInteger)tag;
@end
