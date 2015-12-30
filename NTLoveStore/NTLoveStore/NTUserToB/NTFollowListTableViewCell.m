//
//  NTFollowListTableViewCell.m
//  NTLoveStore
//
//  Created by NTTian on 15/7/23.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import "NTFollowListTableViewCell.h"

@implementation NTFollowListTableViewCell

- (void)awakeFromNib {
    self.contentView.layer.masksToBounds=YES;
    self.contentView.layer.cornerRadius=0.2;
    self.contentView.layer.borderWidth=0.5;
    self.contentView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
