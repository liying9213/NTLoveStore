//
//  NTFunctionTableViewCell.h
//  NTLoveStore
//
//  Created by 李莹 on 15/6/12.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTMemberView.h"
@interface NTFunctionTableViewCell : UITableViewCell <NTMemberViewDelegate>

@property (nonatomic, assign) id delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithMenberNum:(int)num WithWidth:(float)width;

- (void)reloadTheTableCellWithData:(NSArray *)cellAray;

@end
