//
//  JTTitleView.h
//  JTTitleView
//
//  Created by 王锦涛 on 2017/3/13.
//  Copyright © 2017年 JTWang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    // 默认底部线条和文字等宽
    TitleChangeStyleBottomLine1 = 0,
    // 底部线条宽度 > 文字宽度
    TitleChangeStyleBottomLine2,
    // title宽度 平分屏幕宽度
    TitleChangeStyleBottomLine3,
    TitleChangeStyleNoBottomLine
} TitleChangeStyle;

@protocol JTTitleViewDelegate <NSObject>

- (void)didClickTitleLabelWithIndex:(NSInteger)index;

@end
@interface JTTitleView : UIView
- (instancetype)initWithFrame:(CGRect)frame TitleChangeStyle:(TitleChangeStyle)style;
@property (nonatomic,strong)UIColor *backColor;
@property (nonatomic,strong)UIColor *normalColor;
@property (nonatomic,strong)UIColor *selectColor;
@property (nonatomic,strong)NSArray *titles;
// 默认为0
@property (nonatomic,assign)NSInteger selectedIndex;

@property (nonatomic,weak)id <JTTitleViewDelegate>delegate;

// 下面contentView滚动的时候 titleView联动的滚动方法
//- (void)setBottomLineXWithScale:(CGFloat)scale;

@end
