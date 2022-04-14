//
//  TGTNMyExcelToolBaseHeadFunctionView.h
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import <UIKit/UIKit.h>

#import "TGTNMyExcelToolBaseHeadFunctionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolBaseHeadFunctionView : UIView

/// 数据模型
@property (nonatomic, strong) TGTNMyExcelToolBaseHeadFunctionModel *model;

/// 初始化视图
- (void)tgtnInitView;

@end

#pragma mark ------ 分割线

@interface TGTNMyExcelToolBaseHeadFunctionView (TGTNMyExcelToolBaseHeadFunctionViewAdd)

/// 设置数据源
- (void)tgtnSetModel:(id)model;

@end

NS_ASSUME_NONNULL_END
