//
//  NTConsultViewController.m
//  NTLoveStore
//
//  Created by liying on 15/7/9.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTConsultViewController.h"
#import "NTFInishView.h"
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
    NTFInishView *view=[[NTFInishView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [view showTheFinishView];
    view.closeBlock=^(){
        [self.navigationController popViewControllerAnimated:YES];
    };
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
