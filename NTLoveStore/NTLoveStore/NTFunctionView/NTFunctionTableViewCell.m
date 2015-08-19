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
        float xValue=0;
        float theWidth=(width-15*(num+1))/num;
        
        self.memberView1=[[NTMemberView alloc] initWithFrame:CGRectMake(xValue, 10, theWidth, 190)];
        self.memberView1.delegate=self;
        self.memberView1.tag=1;
        [self.memberView1 resetView];
        [self.contentView addSubview:self.memberView1];
        xValue+=theWidth+15;
        
        self.memberView2=[[NTMemberView alloc] initWithFrame:CGRectMake(xValue, 10, theWidth, 190)];
        self.memberView2.delegate=self;
        self.memberView2.tag=1;
        [self.memberView2 resetView];
        [self.contentView addSubview:self.memberView2];
        xValue+=theWidth+15;
        
        self.memberView3=[[NTMemberView alloc] initWithFrame:CGRectMake(xValue, 10, theWidth, 190)];
        self.memberView3.delegate=self;
        self.memberView3.tag=1;
        [self.memberView3 resetView];
        [self.contentView addSubview:self.memberView3];
        xValue+=theWidth+15;
        
        self.memberView4=[[NTMemberView alloc] initWithFrame:CGRectMake(xValue, 10, theWidth, 190)];
        self.memberView4.delegate=self;
        self.memberView4.tag=1;
        [self.memberView4 resetView];
        [self.contentView addSubview:self.memberView4];
        xValue+=theWidth+15;
    }
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [NTColor clearColor];
    return self;
}

- (void)reloadTheTableCellWithData:(NSArray *)cellAray{
    for (int i=0;i<cellAray.count;i++){
        switch (i) {
            case 0:
            {
                self.memberView1.hidden=NO;
                [self.memberView1 reloadTheViewWithData:[cellAray objectAtIndex:i]];
                self.memberView2.hidden=YES;
                self.memberView3.hidden=YES;
                self.memberView4.hidden=YES;
            }
                break;
            case 1:
            {
                self.memberView2.hidden=NO;
                [self.memberView2 reloadTheViewWithData:[cellAray objectAtIndex:i]];
                self.memberView3.hidden=YES;
                self.memberView4.hidden=YES;
            }
                break;
            case 2:
            {
                self.memberView3.hidden=NO;
                [self.memberView3 reloadTheViewWithData:[cellAray objectAtIndex:i]];
                self.memberView4.hidden=YES;
            }
                break;
            case 3:
            {
                self.memberView4.hidden=NO;
                [self.memberView4 reloadTheViewWithData:[cellAray objectAtIndex:i]];
            }
                break;
            default:
                break;
        }
    }
    cellAray=nil;
}

#pragma mark - memberViewDelegate

- (void)memberSelectAction:(id)sender{
    [_delegate memberSelectAction:sender];
}

@end
