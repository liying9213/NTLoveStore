//
//  NTListTableViewCell.h
//  NTLoveStore
//
//  Created by 李莹 on 15/7/23.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *creatDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *weddingDateLabel;
@property (weak, nonatomic) IBOutlet UIView *contentInfoView;

@end
