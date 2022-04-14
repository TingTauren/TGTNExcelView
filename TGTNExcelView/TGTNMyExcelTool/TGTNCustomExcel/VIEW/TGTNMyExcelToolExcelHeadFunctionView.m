//
//  TGTNMyExcelToolExcelHeadFunctionView.m
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolExcelHeadFunctionView.h"

@interface TGTNMyExcelToolExcelHeadFunctionView()
/// 按钮
@property (nonatomic, strong) UIButton *functionButton;
@end

@implementation TGTNMyExcelToolExcelHeadFunctionView

#pragma mark ------ get
- (UIButton *)functionButton {
    if (_functionButton) return _functionButton;
    _functionButton = [UIButton new];
    _functionButton.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    [_functionButton addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return _functionButton;
}

#pragma mark ------ init
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect buttonFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    if (!CGRectIsEmpty(buttonFrame)) {
        if (!CGRectEqualToRect(_functionButton.frame, buttonFrame)) {
            _functionButton.frame = buttonFrame;
        }
    }
}

#pragma mark ------ Click
/// 点击方法
- (void)functionButtonClick:(UIButton *) button {
    TGTNMyExcelToolExcelHeadFunctionModel *headFunctionModel = (TGTNMyExcelToolExcelHeadFunctionModel *)self.model;
    if (headFunctionModel.buttonClickConfig) {
        headFunctionModel.buttonClickConfig(headFunctionModel.selectIndexPath);
    }
}

#pragma mark ------ Super Method
/// 初始化视图
- (void)tgtnInitView {
    [self addSubview:self.functionButton];
}
- (void)tgtnSetModel:(id)model {
    [super tgtnSetModel:model];
    
    self.functionButton.hidden = !self.model.isShow;
}

@end
