//
//  NTLeftTableViewCell.h
//  NTLoveStore
//
//  Created by liying on 15/6/13.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTLeftTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)reloadTheTableCellWithData:(NSDictionary *)cellDic;

@end
