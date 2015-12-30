//
//  NTConsultViewController.m
//  NTLoveStore
//
//  Created by NTTian on 15/7/9.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import "NTConsultViewController.h"
#import "NTFInishView.h"
#import "NTAsynService.h"
@implementation NTConsultViewController

- (IBAction)selcetDate:(id)sender {
    UIButton *btn=(UIButton *)sender;
    
    UIViewController *viewcontroller=[[UIViewController alloc] init];
    [viewcontroller.view addSubview:_datePicker];
    _popoverView=[[UIPopoverController alloc] initWithContentViewController:viewcontroller];
    _popoverView.popoverContentSize = CGSizeMake(320, 162);
    _popoverView.delegate=self;
    [_popoverView presentPopoverFromRect:btn.bounds inView:btn permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)submit:(id)sender {
    if (!_weddingDate.titleLabel.text) {
        [self showEndViewWithText:@"请选择婚期"];
        return;
    }
    if (!_deskTextField.text.length>0) {
        [self showEndViewWithText:@"请填写婚宴桌数"];
        return;
    }
    if (!_bridegroomNameTextField.text.length>0) {
        [self showEndViewWithText:@"请填写新郎姓名"];
        return;
    }
    if (!_bridegroomTelTexField.text.length>0) {
        [self showEndViewWithText:@"请填写新郎电话"];
        return;
    }
    if (!_bridegroomAddressTextField.text.length>0) {
        [self showEndViewWithText:@"请填写新郎地址"];
        return;
    }
    if (!_bridegroomEmailTextField.text.length>0) {
        [self showEndViewWithText:@"请填写邮箱"];
        return;
    }
    if (!_budgetTextField.text.length>0) {
        [self showEndViewWithText:@"请填写婚宴预算"];
        return;
    }
    if (!_brideNameTextField.text.length>0) {
        [self showEndViewWithText:@"请填写新娘姓名"];
        return;
    }
    if (!_brideTelTextField.text.length>0) {
        [self showEndViewWithText:@"请填写新娘电话"];
        return;
    }
    if (!_brideAddressTextField.text.length>0) {
        [self showEndViewWithText:@"请填写新娘地址"];
        return;
    }
    
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    [self showWaitingViewWithText:nil];
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"hq":_weddingDate.titleLabel.text,
                        @"zs":_deskTextField.text,
                        @"je":_budgetTextField.text,
                        @"xl":_bridegroomNameTextField.text,
                        @"xn":_brideNameTextField.text,
                        @"lphone":_bridegroomTelTexField.text,
                        @"nphone":_brideTelTextField.text,
                        @"laddr":_bridegroomAddressTextField.text,
                        @"naddr":_brideAddressTextField.text,
                        @"email":_bridegroomEmailTextField.text};
    [NTAsynService requestWithHead:zixunOrderBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
             __strong typeof(self) self=__weakself;
            NTFInishView *view=[[NTFInishView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            [view showTheFinishView];
            view.closeBlock=^(){
                [self.navigationController popViewControllerAnimated:YES];
            };
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
        finishData=nil;
    }];
    dic=nil;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str=[formatter stringFromDate:_datePicker.date];
    [_weddingDate setTitle:str forState:UIControlStateNormal];
    [_popoverView.contentViewController removeFromParentViewController];
    _popoverView=nil;
    
}

- (void)backBtnAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
