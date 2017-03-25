//
//  GNSelectAreaCell.h
//  JTTitleView
//
//  Created by 王锦涛 on 2017/3/20.
//  Copyright © 2017年 JTWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNSelectAreaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic,assign)BOOL isSelect;
@end
