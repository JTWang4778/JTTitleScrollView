//
//  GNSelectAreaDataManager.h
//  JTTitleView
//
//  Created by 王锦涛 on 2017/3/18.
//  Copyright © 2017年 JTWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNSelectAreaDataManager : NSObject


- (NSArray *)provinceArray;
- (NSArray *)cityArrayWithProvinceName:(NSString *)name;
- (NSArray *)areaArrayWithProvinceName:(NSString *)provinceName CityName:(NSString *)cityName;

@end
