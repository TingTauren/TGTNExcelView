//
//  TGTNMyExcelToolBaseHeadView.m
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import "TGTNMyExcelToolBaseHeadView.h"

@interface TGTNMyExcelToolBaseHeadView()
@end

@implementation TGTNMyExcelToolBaseHeadView

#pragma mark ------ get

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

#pragma mark ------ Private

#pragma mark ------ Public
/// 设置数据源
- (void)tgtnSetModel:(id)model {
    _model = model;
}
/// 添加子视图
- (void)tgtnAddChildView {
}
/// 修改子视图大小
- (void)tgtnChangeChildFrame {
}

@end
