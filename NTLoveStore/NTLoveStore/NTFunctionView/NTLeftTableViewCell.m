//
//  NTLeftTableViewCell.m
//  NTLoveStore
//
//  Created by liying on 15/6/13.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTLeftTableViewCell.h"
#import "NTNormalHead.h"
@implementation NTLeftTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 50)];
        _titleLabel.backgroundColor=[NTColor clearColor];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.textColor=[NTColor blackColor];
        _titleLabel.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_titleLabel.frame), 20, 10 , 11)];
        imageView.backgroundColor=[NTColor clearColor];
        imageView.image=[NTImage imageWithFileName:@"moreicon.png"];
        [self.contentView addSubview:imageView];
        
        self.contentView.layer.borderWidth=0.5;
        self.contentView.layer.borderColor=[[NTColor lightGrayColor] CGColor];
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [NTColor colorWithHexString:NTBlueColor];
        
    }
    return self;
}

- (void)reloadTheTableCellWithData:(NSDictionary *)cellDic{
    _titleLabel.textColor=[NTColor blackColor];
    _titleLabel.text=[cellDic objectForKey:@"title"];
}

@end
