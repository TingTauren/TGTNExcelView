//
//  TGTNMyExcelToolBaseMainView.h
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import <UIKit/UIKit.h>

#import "TGTNMyExcelToolBaseMainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolBaseMainView : UIView

/// 数据模型
@property (nonatomic, strong) TGTNMyExcelToolBaseMainModel *model;

/// 设置数据源
- (void)tgtnSetModel:(id)model;

/// 添加子视图
- (void)tgtnAddChildView;
/// 修改子视图大小
- (void)tgtnChangeChildFrame;

@end

NS_ASSUME_NONNULL_END
