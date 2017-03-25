//
//  ViewController.m
//  JTTitleView
//
//  Created by 王锦涛 on 2017/3/13.
//  Copyright © 2017年 JTWang. All rights reserved.
//

#import "ViewController.h"
#import "JTTitleView.h"
#import "GNSelectAreaController.h"
#import "UIColor+Random.h"

#define randomColor random（arc4random_uniform（256），arc4random_uniform（256），arc4random_uniform（256），arc4random_uniform（256））

@interface ViewController ()<UIScrollViewDelegate,JTTitleViewDelegate>

@property (nonatomic,weak)JTTitleView *titleView;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,weak)UIScrollView *contentScrollView;

@end

@implementation ViewController
- (NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = @[@"推荐",@"热点啊",@"北京",@"阳光宽屏",@"社会语法",@"头条",@"分类",@"问答",@"娱乐"];
    }
    return _titleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleView];
    [self addContenScrollView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    /*
        有bug  首次启动 点击看到的最后一个title的时候  应该滚动title
     */
}

- (void)addTitleView
{
    JTTitleView *titleView = [[JTTitleView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44) TitleChangeStyle:TitleChangeStyleBottomLine2];
//    titleView.titles = self.titleArray;
    titleView.backColor = [UIColor whiteColor];
    titleView.normalColor = [UIColor blackColor];
    titleView.selectColor = [UIColor orangeColor];
    titleView.titles = @[@"小学",@"中学"];
    titleView.titles = @[@"小学",@"初中",@"高中"];
    titleView.delegate = self;
    
    [self.view addSubview:titleView];
    self.titleView = titleView;
}

- (void)addContenScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 108, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 108)];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    _contentScrollView = scrollView;
    
    for (int  i= 0; i < self.titleArray.count; i++) {
        CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, 0,scrollView.frame.size.width, scrollView.frame.size.height) style:UITableViewStylePlain];
        tableView.tag = i;
        tableView.backgroundColor = [UIColor RandomColor];
        [self.contentScrollView addSubview:tableView];
    }
    
    self.contentScrollView.contentSize = CGSizeMake(scrollView.bounds.size.width * self.titleArray.count, scrollView.bounds.size.height);

}



//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat scale = scrollView.contentOffset.x / (scrollView.contentSize.width - scrollView.bounds.size.width);
//    [self.titleView setBottomLineXWithScale:scale];
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.titleView.selectedIndex = currentIndex;
}


#pragma mark - JTTitleViewDelegate 代理方法
- (void)didClickTitleLabelWithIndex:(NSInteger)index
{
    CGFloat offsetX = self.contentScrollView.frame.size.width * index;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    GNSelectAreaController *as = [GNSelectAreaController new];
//    [self.navigationController pushViewController:as animated:YES];
}

@end
