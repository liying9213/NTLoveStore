//
//  NTFunctionTableViewCell.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/12.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTFunctionTableViewCell.h"
#import "NTMemberView.h"
@implementation NTFunctionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithMenberNum:(int)num WithWidth:(float)width{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        float xValue=10;
        float theWidth=(width-10*(num+1))/num;
        for (int i=0; i<num; i++) {
            NTMemberView *menberView=[[NTMemberView alloc] initWithFrame:CGRectMake(xValue, 10, theWidth, 150)];
            menberView.delegate=self;
            menberView.tag=i;
            [menberView resetView];
            [self.contentView addSubview:menberView];
            xValue+=theWidth+10;
        }
    }
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [NTColor clearColor];
    return self;
}

- (void)reloadTheTableCellWithData:(NSArray *)cellAray{
    NSArray *subAry=self.contentView.subviews;
    for (UIView *view in subAry) {
        if ([view.class isSubclassOfClass:[NTMemberView class]]) {
            NTMemberView *memberView=(NTMemberView *)view;
            if (cellAray.count>=memberView.tag+1) {
                memberView.hidden=NO;
                [memberView reloadTheViewWithData:[cellAray objectAtIndex:memberView.tag]];
            }
            else{
                memberView.hidden=YES;
            }
        }
    }
}

#pragma mark - memberViewDelegate

- (void)memberSelectAction:(id)sender{
    [_delegate memberSelectAction:sender];
}

@end
