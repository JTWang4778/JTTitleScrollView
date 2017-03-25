//
//  GNSelectAreaCell.m
//  JTTitleView
//
//  Created by 王锦涛 on 2017/3/20.
//  Copyright © 2017年 JTWang. All rights reserved.
//

#import "GNSelectAreaCell.h"

@interface GNSelectAreaCell()

@end
@implementation GNSelectAreaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectImageView.image = [UIImage imageNamed:@"note"];
    self.selectImageView.hidden = YES;
}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    
    if (isSelect) {
        self.contentLabel.textColor = [UIColor redColor];
        self.selectImageView.hidden = NO;
    }else{
        self.contentLabel.textColor = [UIColor blackColor];
        self.selectImageView.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
