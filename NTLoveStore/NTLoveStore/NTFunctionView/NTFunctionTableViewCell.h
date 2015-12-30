//
//  NTFunctionTableViewCell.h
//  NTLoveStore
//
//  Created by NTTian on 15/6/12.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTMemberView.h"
@interface NTFunctionTableViewCell : UITableViewCell <NTMemberViewDelegate>

@property (nonatomic, assign) id delegate;

@property (nonatomic, strong) NTMemberView *memberView1;

@property (nonatomic, strong) NTMemberView *memberView2;

@property (nonatomic, strong) NTMemberView *memberView3;

@property (nonatomic, strong) NTMemberView *memberView4;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithMenberNum:(int)num WithWidth:(float)width;

- (void)reloadTheTableCellWithData:(NSArray *)cellAray;

@end
