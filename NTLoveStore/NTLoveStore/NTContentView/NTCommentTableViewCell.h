//
//  NTCommentTableViewCell.h
//  NTLoveStore
//
//  Created by NTTian on 15/8/26.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *userLabel;

@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UILabel *dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withWidth:(float)width;
@end
