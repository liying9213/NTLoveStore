//
//  NTCommentTableViewCell.h
//  NTLoveStore
//
//  Created by liying on 15/8/26.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *userLabel;

@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UILabel *dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withWidth:(float)width;
@end
