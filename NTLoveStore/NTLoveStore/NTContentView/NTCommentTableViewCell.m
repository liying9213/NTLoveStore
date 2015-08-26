//
//  NTCommentTableViewCell.m
//  NTLoveStore
//
//  Created by liying on 15/8/26.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTCommentTableViewCell.h"

@implementation NTCommentTableViewCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withWidth:(float)width{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _userLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 5,width-40, 20)];
        _userLabel.backgroundColor=[UIColor clearColor];
        _userLabel.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:_userLabel];
        
        _commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(_userLabel.frame)+5, width-40, 40)];
        _commentLabel.backgroundColor=[UIColor clearColor];
        _commentLabel.font=[UIFont systemFontOfSize:15];
        _commentLabel.numberOfLines=0;
        _commentLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_commentLabel];
        
        _dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(width-120, CGRectGetHeight(_commentLabel.frame)+CGRectGetMinY(_commentLabel.frame)+5, 100, 20)];
        _dateLabel.backgroundColor=[UIColor clearColor];
        _dateLabel.font=[UIFont systemFontOfSize:15];
        _dateLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_dateLabel];
        
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(_dateLabel.frame)+CGRectGetMinY(_dateLabel.frame)+4, width-40, 1)];
        lineView.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
    }
    return self;
}

@end
