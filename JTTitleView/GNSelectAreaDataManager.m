//
//  GNSelectAreaDataManager.m
//  JTTitleView
//
//  Created by 王锦涛 on 2017/3/18.
//  Copyright © 2017年 JTWang. All rights reserved.
//

#import "GNSelectAreaDataManager.h"

@interface GNSelectAreaDataManager()

@property (nonatomic,strong)NSArray *provinceArr;

@end
@implementation GNSelectAreaDataManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadData];
    }
    return self;
}

- (void)loadData
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"address" ofType:@"plist"];
    NSDictionary*addressDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    _provinceArr = [addressDic objectForKey:@"address"];
}

- (NSArray *)provinceArray
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in _provinceArr) {
        NSString *provinceName = dict[@"name"];
        [arr addObject:provinceName];
    }
    return arr.copy;
}
- (NSArray *)cityArrayWithProvinceName:(NSString *)name
{
    NSArray *cityDictArr;
    for (NSDictionary *dict in _provinceArr) {
        NSString *provinceName = dict[@"name"];
        if ([provinceName isEqualToString:name]) {
            cityDictArr = dict[@"sub"];
        }
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in cityDictArr) {
        NSString *cityName = dict[@"name"];
        [arr addObject:cityName];
    }
    return arr.copy;
}
- (NSArray *)areaArrayWithProvinceName:(NSString *)provinceName CityName:(NSString *)cityName
{
    NSArray *cityDictArr;
    for (NSDictionary *dict in _provinceArr) {
        NSString *province = dict[@"name"];
        if ([province isEqualToString:provinceName]) {
            cityDictArr = dict[@"sub"];
        }
    }
    NSArray *areaArr;
    for (NSDictionary *dict in cityDictArr) {
        NSString *cName = dict[@"name"];
        if ([cName isEqualToString:cityName]) {
            areaArr = dict[@"sub"];
        }
    }
    
    return areaArr;
}

@end
