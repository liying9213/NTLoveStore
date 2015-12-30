//
//  NTCommentView.m
//  NTLoveStore
//
//  Created by NTTian on 15/8/26.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import "NTCommentBodyView.h"

@implementation NTCommentBodyView

- (id) initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) resetView{
    _userLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(self.frame), 20)];
    _userLabel.backgroundColor=[UIColor clearColor];
    _userLabel.font=[UIFont systemFontOfSize:15];
    [self addSubview:_userLabel];
    
    _commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_userLabel.frame)+5, CGRectGetWidth(self.frame), 40)];
    _commentLabel.backgroundColor=[UIColor clearColor];
    _commentLabel.font=[UIFont systemFontOfSize:15];
    _commentLabel.numberOfLines=0;
    _commentLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    [self addSubview:_commentLabel];
    
    _dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-100, CGRectGetHeight(_commentLabel.frame)+CGRectGetMinY(_commentLabel.frame)+5, 100, 20)];
    _dateLabel.backgroundColor=[UIColor clearColor];
    _dateLabel.font=[UIFont systemFontOfSize:15];
    _dateLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:_dateLabel];
}

- (void) reloadTheViewWithData:(NSDictionary *)dic{
    if (!dic) {
        return;
    }
    _userLabel.text=[NSString stringWithFormat:@"用户：%@",dic[@"tag"]];
    _commentLabel.text=dic[@"content"];
    _dateLabel.text=dic[@"create_time"];
}


@end
