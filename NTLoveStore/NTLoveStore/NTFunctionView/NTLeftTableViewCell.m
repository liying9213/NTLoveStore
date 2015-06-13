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
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
        _titleLabel.backgroundColor=[NTColor clearColor];
        [self.contentView addSubview:_titleLabel];
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_titleLabel.frame), 0, 40, 80)];
        imageView.backgroundColor=[NTColor clearColor];
        imageView.image=[NTImage imageWithFileName:nil];
        [self.contentView addSubview:imageView];
        
        self.contentView.layer.masksToBounds=YES;
        self.contentView.layer.cornerRadius=0.2;
        self.contentView.layer.borderWidth=0.5;
        self.contentView.layer.borderColor=[[NTColor lightGrayColor] CGColor];
        
    }
    return self;
}

- (void)reloadTheTableCellWithData:(NSDictionary *)cellDic{
    _titleLabel.text=[cellDic objectForKey:@"name"];
}

@end
