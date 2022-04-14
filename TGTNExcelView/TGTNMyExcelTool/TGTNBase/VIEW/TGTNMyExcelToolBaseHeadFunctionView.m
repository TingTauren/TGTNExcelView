//
//  TGTNMyExcelToolBaseHeadFunctionView.m
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import "TGTNMyExcelToolBaseHeadFunctionView.h"

@implementation TGTNMyExcelToolBaseHeadFunctionView

#pragma mark ------ get

#pragma mark ------ set

#pragma mark ------ init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self tgtnInitView];
        [self _tgtnInitEvent];
    }
    return self;
}
/// 初始化视图
- (void)tgtnInitView {
    
}
/// 添加事件
- (void)_tgtnInitEvent {
}

#pragma mark ------ Private

#pragma mark ------ Public

@end

#pragma mark ------ 分割线

@implementation TGTNMyExcelToolBaseHeadFunctionView (TGTNMyExcelToolBaseHeadFunctionViewAdd)

/// 设置数据源
- (void)tgtnSetModel:(id)model {
    _model = model;
}

@end
