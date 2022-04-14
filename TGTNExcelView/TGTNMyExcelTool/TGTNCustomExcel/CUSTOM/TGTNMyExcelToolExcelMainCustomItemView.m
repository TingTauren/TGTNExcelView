//
//  TGTNMyExcelToolExcelMainCustomItemView.m
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolExcelMainCustomItemView.h"

@interface TGTNMyExcelToolExcelMainCustomItemView()
/// 标签
@property (nonatomic, strong) UIButton *customButton;
@end

@implementation TGTNMyExcelToolExcelMainCustomItemView

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
/// 初始化视图
- (void)_tgtnInitView {
}
/// 添加事件
- (void)_tgtnInitEvent {
}

#pragma mark ------ Click
/// 自定义按钮点击
- (void)customButtonClick:(UIButton *) button {
    NSLog(@"内容点击 - %ld - %ld", _model.indexPath.row, _model.indexPath.section);
    if (_model.buttonClickConfig) {
        _model.buttonClickConfig(_model.indexPath, self);
    }
}

#pragma mark ------ Private

#pragma mark ------ Public
/// 设置数据源
- (void)tgtnSetModel:(id)model {
    _model = model;
    
    NSInteger columnType = [_model.customDataModel.columnType integerValue];
    
    if (columnType == 0) {
        [_customButton setTitle:_model.customDataModel.title forState:UIControlStateNormal];
    } else if (columnType == 1) {
    }
}
/// 添加子视图
- (void)tgtnAddChildView {
    [self addSubview:self.customButton];
}
/// 修改子视图大小
- (void)tgtnChangeChildFrame {
    _customButton.frame = self.bounds;
}

@end
