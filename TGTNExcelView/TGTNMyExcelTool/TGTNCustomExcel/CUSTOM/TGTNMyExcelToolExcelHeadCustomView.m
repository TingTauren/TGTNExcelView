//
//  TGTNMyExcelToolExcelHeadCustomView.m
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolExcelHeadCustomView.h"

@interface TGTNMyExcelToolExcelHeadCustomView()
/// 标签
@property (nonatomic, strong) UIButton *customButton;

/// 是否第一次刷新
@property (nonatomic, assign) BOOL isFristLayoutSubviews;
@end

@implementation TGTNMyExcelToolExcelHeadCustomView

#pragma mark ------ get
- (UIButton *)customButton {
    if (_customButton) return _customButton;
    _customButton = [UIButton new];
    _customButton.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    [_customButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_customButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [_customButton addTarget:self action:@selector(customButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return _customButton;
}

#pragma mark ------ set

#pragma mark ------ init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _tgtnInitView];
        [self _tgtnInitEvent];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect buttonFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    if (!CGRectIsEmpty(self.frame) && _isFristLayoutSubviews) {
        _isFristLayoutSubviews = NO;
        _customButton.frame = buttonFrame;
    } else {
        if (!CGRectEqualToRect(_customButton.frame, buttonFrame)) {
            _customButton.frame = buttonFrame;
        }
    }
}
/// 初始化视图
- (void)_tgtnInitView {
    _isFristLayoutSubviews = YES;
    
    [self addSubview:self.customButton];
}
/// 添加事件
- (void)_tgtnInitEvent {
}

/// 自定义按钮点击
- (void)customButtonClick:(UIButton *) button {
    if (_model.buttonClickConfig) {
        _model.buttonClickConfig(_model.index, self);
    }
}

#pragma mark ------ Private

#pragma mark ------ Public
/// 设置数据源
- (void)tgtnSetModel:(id)model {
    _model = model;
    
    NSInteger columnType = [_model.customDataModel.columnType integerValue];
    
    _customButton.hidden = YES;
    if (columnType == 0) {
        _customButton.hidden = NO;
        [_customButton setTitle:_model.customDataModel.title forState:UIControlStateNormal];
    } else if (columnType == 1) {
    }
}

@end
