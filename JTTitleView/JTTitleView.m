//
//  JTTitleView.m
//  JTTitleView
//
//  Created by 王锦涛 on 2017/3/13.
//  Copyright © 2017年 JTWang. All rights reserved.
//

#import "JTTitleView.h"
#import "UIColor+Random.h"
#define TITLE_FONT_SIZE 18
#define TITLE_WIDTH 60
#define MARGIN 30

@interface JTTitleView()
@property (nonatomic,assign)TitleChangeStyle changeStyle;
@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,weak)UIView *bottomLine;

@end
@implementation JTTitleView

- (instancetype)initWithFrame:(CGRect)frame TitleChangeStyle:(TitleChangeStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        _changeStyle = style;
        [self setupChildViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildViews];
    }
    return self;
}


- (void)setupChildViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    _scrollView = scrollView;
}


- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    for (id asd in self.scrollView.subviews) {
        if ([asd isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)asd;
            [label removeFromSuperview];
        }
    }
    [self.bottomLine removeFromSuperview];
    CGRect previousLabelFrame = CGRectMake(0, 0, 0, 0);
    for (int i = 0; i< titles.count; i++) {
        UILabel *la = [UILabel new];
        la.tag = i + 100;
        la.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
        la.textAlignment = NSTextAlignmentCenter;
        la.text = titles[i];
        la.textColor = _normalColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickTitle:)];
        [la addGestureRecognizer:tap];
        la.userInteractionEnabled = YES;
        // 判断如果是平分宽度的样式
        if (_changeStyle == TitleChangeStyleBottomLine3) {
            CGFloat width = self.frame.size.width / titles.count;
            la.frame = CGRectMake(i*width, 0, width, self.frame.size.height);
        }else{
            if (i == 100) {
                la.frame = CGRectMake(0, 0, [self titleTextWidthWithContent:la.text] + MARGIN, self.frame.size.height);
            }else{
                la.frame = CGRectMake(CGRectGetMaxX(previousLabelFrame), 0, [self titleTextWidthWithContent:la.text] + MARGIN, self.frame.size.height);
            }
        }
        previousLabelFrame = la.frame;
        [self.scrollView addSubview:la];
    }
    
    UIView *bottom = [UIView new];
    bottom.backgroundColor = _selectColor;
    NSString *firstTitle = _titles[0];
    CGRect bottomLineFrame;
    CGFloat firstTitleWidth = [self titleTextWidthWithContent:firstTitle];
    switch (_changeStyle) {
        case TitleChangeStyleBottomLine1:
        {
            // 默认样式
            bottomLineFrame = CGRectMake(MARGIN *0.5, self.frame.size.height - 3 -1, firstTitleWidth, 3);
            
        }
            break;
        case TitleChangeStyleBottomLine2:
        {
            bottomLineFrame = CGRectMake(1, self.frame.size.height - 3 -1, firstTitleWidth + MARGIN -2, 3);
        }
            break;
        case TitleChangeStyleBottomLine3:
        {
            CGFloat width = self.frame.size.width / titles.count;
            bottomLineFrame = CGRectMake(1, self.frame.size.height - 3 -1, width -2, 3);
        }
            break;
        case TitleChangeStyleNoBottomLine:
        {
            
        }
            break;
            
        default:
            break;
    }
    bottom.frame = bottomLineFrame;
    bottom.layer.cornerRadius = 1.5;
    bottom.layer.masksToBounds = YES;
    [self.scrollView addSubview:bottom];
    self.bottomLine = bottom;
    
    UILabel *lastLabel = (UILabel *)[self.scrollView viewWithTag:100 + _titles.count -1];
    if (lastLabel) {
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), self.frame.size.height);
    }
    
}

- (CGFloat)titleTextWidthWithContent:(NSString *)content
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
    label.text = content;
    [label sizeToFit];
    return label.frame.size.width;
}

- (void)didClickTitle:(UITapGestureRecognizer *)rec
{
    UILabel *clickLabel = (UILabel *)rec.view;
    [self.delegate didClickTitleLabelWithIndex:clickLabel.tag -100];
    [self didClickTitleWithLable:clickLabel];
    
}

- (void)didClickTitleWithLable:(UILabel *)clickLabel
{
    CGFloat centerX = clickLabel.frame.origin.x + 0.5*clickLabel.frame.size.width;
    CGFloat newContentOffsetX;
    if (centerX > self.scrollView.frame.size.width * 0.5) {
        
        if (self.scrollView.contentSize.width - centerX < self.scrollView.frame.size.width * 0.5) {
            
            newContentOffsetX = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
            
        }else{
            
            newContentOffsetX = centerX - self.scrollView.frame.size.width * 0.5;
        }
        
    }else{
        
        newContentOffsetX = 0;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(newContentOffsetX, 0);
        switch (_changeStyle) {
            case TitleChangeStyleBottomLine1:
            {
                self.bottomLine.frame = CGRectMake(clickLabel.frame.origin.x + MARGIN * 0.5, 40, clickLabel.frame.size.width - MARGIN, 3);
            }
                break;
            case TitleChangeStyleBottomLine2:
            {
                self.bottomLine.frame = CGRectMake(clickLabel.frame.origin.x + 1, 40, clickLabel.frame.size.width - 2, 3);
            }
                break;
            case TitleChangeStyleBottomLine3:
            {
                self.bottomLine.frame = CGRectMake(clickLabel.frame.origin.x + 1, 40, clickLabel.frame.size.width - 2, 3);
            }
                break;
            case TitleChangeStyleNoBottomLine:
            {
                
            }
                break;
                
            default:
                break;
        }
        
    }];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    for (id childView in self.scrollView.subviews) {
        if ([childView isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)childView;
            if (label.tag == (selectedIndex + 100)) {
                [self didClickTitleWithLable:label];
                break;
            }
            
        }
    }
}

- (void)setBackColor:(UIColor *)backColor
{
    _backColor = backColor;
    self.scrollView.backgroundColor = backColor;
}

- (void)setBottomLineXWithScale:(CGFloat)scale
{
    CGFloat x = scale * (self.scrollView.contentSize.width - TITLE_WIDTH);
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomLine.frame = CGRectMake(x+1, 40, TITLE_WIDTH, 3);
    }];
    
}

@end
